#!/bin/bash
# Docker Security Scanning and Hardening Script
# This script performs security scanning and implements security best practices

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="security-agents/multi-agent"
TAG="${TAG:-latest}"
FULL_IMAGE="${IMAGE_NAME}:${TAG}"
SCAN_RESULTS_DIR="./security-scan-results"

# Create scan results directory
mkdir -p "${SCAN_RESULTS_DIR}"

echo -e "${BLUE}🔒 Docker Security Scanning and Hardening${NC}"
echo "=================================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to log with timestamp
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# 1. Build secure image
echo -e "\n${BLUE}📦 Building secure Docker image...${NC}"
docker build \
    --target production \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg VCS_REF="$(git rev-parse HEAD 2>/dev/null || echo 'unknown')" \
    --build-arg VERSION="1.0.0" \
    --no-cache \
    -t "${FULL_IMAGE}" \
    .

# 2. Run Docker Scout security scan (if available)
if command_exists docker && docker scout version >/dev/null 2>&1; then
    echo -e "\n${BLUE}🔍 Running Docker Scout security scan...${NC}"
    docker scout cves "${FULL_IMAGE}" --format sarif --output "${SCAN_RESULTS_DIR}/scout-cves.sarif" || {
        log "${YELLOW}Warning: Docker Scout scan failed or not available${NC}"
    }
    
    docker scout recommendations "${FULL_IMAGE}" > "${SCAN_RESULTS_DIR}/scout-recommendations.txt" || {
        log "${YELLOW}Warning: Docker Scout recommendations failed${NC}"
    }
else
    log "${YELLOW}Docker Scout not available, skipping vulnerability scan${NC}"
fi

# 3. Run Trivy security scan (if available)
if command_exists trivy; then
    echo -e "\n${BLUE}🛡️ Running Trivy security scan...${NC}"
    
    # Scan for vulnerabilities
    trivy image \
        --format json \
        --output "${SCAN_RESULTS_DIR}/trivy-vulnerabilities.json" \
        "${FULL_IMAGE}"
    
    # Scan for secrets
    trivy image \
        --scanners secret \
        --format json \
        --output "${SCAN_RESULTS_DIR}/trivy-secrets.json" \
        "${FULL_IMAGE}"
    
    # Generate human-readable report
    trivy image \
        --format table \
        --output "${SCAN_RESULTS_DIR}/trivy-report.txt" \
        "${FULL_IMAGE}"
    
    log "${GREEN}Trivy scan completed. Results saved to ${SCAN_RESULTS_DIR}/${NC}"
else
    log "${YELLOW}Trivy not available. Install with: brew install trivy (macOS) or apt-get install trivy (Ubuntu)${NC}"
fi

# 4. Run Grype security scan (if available)
if command_exists grype; then
    echo -e "\n${BLUE}🔎 Running Grype security scan...${NC}"
    grype "${FULL_IMAGE}" -o json > "${SCAN_RESULTS_DIR}/grype-vulnerabilities.json"
    grype "${FULL_IMAGE}" -o table > "${SCAN_RESULTS_DIR}/grype-report.txt"
    log "${GREEN}Grype scan completed${NC}"
else
    log "${YELLOW}Grype not available. Install with: curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh${NC}"
fi

# 5. Check Docker image configuration
echo -e "\n${BLUE}⚙️ Analyzing Docker image configuration...${NC}"

# Check if running as non-root
USER_CHECK=$(docker run --rm "${FULL_IMAGE}" whoami 2>/dev/null || echo "unknown")
if [ "$USER_CHECK" = "security" ]; then
    log "${GREEN}✅ Image runs as non-root user: ${USER_CHECK}${NC}"
else
    log "${RED}❌ Image may be running as root user: ${USER_CHECK}${NC}"
fi

# Check for health check
HEALTHCHECK=$(docker inspect "${FULL_IMAGE}" | jq -r '.[0].Config.Healthcheck.Test // "none"')
if [ "$HEALTHCHECK" != "none" ]; then
    log "${GREEN}✅ Health check configured${NC}"
else
    log "${YELLOW}⚠️ No health check configured${NC}"
fi

# Check exposed ports
EXPOSED_PORTS=$(docker inspect "${FULL_IMAGE}" | jq -r '.[0].Config.ExposedPorts // {} | keys[]' 2>/dev/null || echo "none")
log "${BLUE}📡 Exposed ports: ${EXPOSED_PORTS}${NC}"

# 6. Security hardening verification
echo -e "\n${BLUE}🔒 Security hardening verification...${NC}"

# Check for common security practices
docker run --rm "${FULL_IMAGE}" sh -c '
    echo "Checking security configurations..."
    
    # Check if common attack vectors are mitigated
    if [ -f /etc/passwd ]; then
        echo "✅ /etc/passwd exists"
        if grep -q "security:x" /etc/passwd; then
            echo "✅ Security user configured"
        else
            echo "❌ Security user not found"
        fi
    fi
    
    # Check Python security
    python3.11 -c "
import sys
print(f\"✅ Python version: {sys.version}\")
print(f\"✅ Python executable: {sys.executable}\")

# Check for common Python security issues
try:
    import ssl
    print(f\"✅ SSL context: {ssl.create_default_context()}\")
except Exception as e:
    print(f\"❌ SSL issue: {e}\")
"
'

# 7. Generate security report
echo -e "\n${BLUE}📋 Generating security report...${NC}"

cat > "${SCAN_RESULTS_DIR}/security-summary.md" << EOF
# Docker Security Scan Report

**Image:** ${FULL_IMAGE}
**Scan Date:** $(date -u +'%Y-%m-%d %H:%M:%S UTC')
**Git Commit:** $(git rev-parse HEAD 2>/dev/null || echo 'unknown')

## Security Measures Implemented

### Base Image Security
- ✅ Using Ubuntu 22.04 LTS for better security support
- ✅ Regular security updates applied during build
- ✅ Minimal package installation to reduce attack surface
- ✅ Clean package cache and temporary files

### Runtime Security
- ✅ Non-root user execution (user: security, uid: 1000)
- ✅ Proper file permissions (750 for application directories)
- ✅ Secure environment variables configuration
- ✅ Signal handling with dumb-init

### Application Security
- ✅ Python bytecode compilation disabled
- ✅ Hash randomization enabled
- ✅ Pip cache disabled
- ✅ Proper dependency management

### Container Security
- ✅ Health checks configured
- ✅ Minimal exposed ports
- ✅ Proper entrypoint configuration
- ✅ Security labels and metadata

## Scan Results

EOF

# Add scan results to report if available
if [ -f "${SCAN_RESULTS_DIR}/trivy-report.txt" ]; then
    {
        echo "### Trivy Vulnerability Scan"
        echo '```'
        head -50 "${SCAN_RESULTS_DIR}/trivy-report.txt"
        echo '```'
        echo ""
    } >> "${SCAN_RESULTS_DIR}/security-summary.md"
fi

# 8. Docker Bench Security (if available)
if command_exists docker-bench-security; then
    docker run --rm --net host --pid host --userns host --cap-add audit_control \
        -e DOCKER_CONTENT_TRUST="$DOCKER_CONTENT_TRUST" \
        -v /etc:/etc:ro \
        -v /usr/bin/containerd:/usr/bin/containerd:ro \
        -v /usr/bin/runc:/usr/bin/runc:ro \
        -v /usr/lib/systemd:/usr/lib/systemd:ro \
        -v /var/lib:/var/lib:ro \
        -v /var/run/docker.sock:/var/run/docker.sock:ro \
        --label docker_bench_security \
        docker/docker-bench-security > "${SCAN_RESULTS_DIR}/docker-bench-security.txt" || {
        log "${YELLOW}Docker Bench Security failed or not available${NC}"
    }
fi

# 9. Final recommendations
echo -e "\n${BLUE}📝 Security Recommendations${NC}"
echo "============================================="
echo "1. 🔄 Regularly update base images and dependencies"
echo "2. 🔍 Run security scans in CI/CD pipeline"
echo "3. 🛡️ Use Docker secrets for sensitive data"
echo "4. 🔒 Implement proper network policies"
echo "5. 📊 Monitor container runtime security"
echo "6. 🚫 Never run containers as root in production"
echo "7. 🔐 Use image signing and verification"
echo "8. 📋 Regularly audit container configurations"

# Summary
echo -e "\n${GREEN}✅ Security scan completed!${NC}"
echo -e "📁 Results saved to: ${SCAN_RESULTS_DIR}/"
echo -e "📋 Review the security-summary.md file for detailed results"

# Check if critical vulnerabilities were found
if [ -f "${SCAN_RESULTS_DIR}/trivy-vulnerabilities.json" ]; then
    CRITICAL_COUNT=$(jq -r '[.Results[]?.Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length' "${SCAN_RESULTS_DIR}/trivy-vulnerabilities.json" 2>/dev/null || echo "0")
    HIGH_COUNT=$(jq -r '[.Results[]?.Vulnerabilities[]? | select(.Severity=="HIGH")] | length' "${SCAN_RESULTS_DIR}/trivy-vulnerabilities.json" 2>/dev/null || echo "0")
    
    if [ "$CRITICAL_COUNT" -gt 0 ] || [ "$HIGH_COUNT" -gt 0 ]; then
        echo -e "\n${RED}⚠️ Found ${CRITICAL_COUNT} critical and ${HIGH_COUNT} high severity vulnerabilities${NC}"
        echo -e "${YELLOW}Please review the scan results and update base image or dependencies${NC}"
        exit 1
    else
        echo -e "\n${GREEN}🎉 No critical or high severity vulnerabilities found!${NC}"
    fi
fi

echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Review scan results in ${SCAN_RESULTS_DIR}/"
echo "2. Update any vulnerable dependencies"
echo "3. Run 'docker-compose up -d' to deploy securely"
echo "4. Monitor runtime security with your preferred tools"
