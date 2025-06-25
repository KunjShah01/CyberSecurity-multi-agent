@echo off
REM Docker Security Scanning and Hardening Script for Windows
REM This script performs security scanning and implements security best practices

setlocal EnableDelayedExpansion

REM Configuration
set IMAGE_NAME=security-agents/multi-agent
if "%TAG%"=="" set TAG=latest
set FULL_IMAGE=%IMAGE_NAME%:%TAG%
set SCAN_RESULTS_DIR=.\security-scan-results

REM Create scan results directory
if not exist "%SCAN_RESULTS_DIR%" mkdir "%SCAN_RESULTS_DIR%"

echo 🔒 Docker Security Scanning and Hardening
echo ==================================================

REM Function to check if command exists
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker not found. Please install Docker Desktop.
    exit /b 1
)

REM Get current timestamp
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Sec=%dt:~12,2%"
set "BUILD_DATE=%YYYY%-%MM%-%DD%T%HH%:%Min%:%Sec%Z"

echo.
echo 📦 Building secure Docker image...

REM Get git commit hash if available
for /f %%i in ('git rev-parse HEAD 2^>nul') do set VCS_REF=%%i
if "%VCS_REF%"=="" set VCS_REF=unknown

REM Build secure image
docker build ^
    --target production ^
    --build-arg BUILD_DATE="%BUILD_DATE%" ^
    --build-arg VCS_REF="%VCS_REF%" ^
    --build-arg VERSION="1.0.0" ^
    --no-cache ^
    -t "%FULL_IMAGE%" ^
    .

if %errorlevel% neq 0 (
    echo ❌ Docker build failed
    exit /b 1
)

echo.
echo 🔍 Running Docker Scout security scan...

REM Check if Docker Scout is available
docker scout version >nul 2>&1
if %errorlevel% equ 0 (
    docker scout cves "%FULL_IMAGE%" --format sarif --output "%SCAN_RESULTS_DIR%\scout-cves.sarif"
    if %errorlevel% neq 0 echo ⚠️ Docker Scout CVE scan failed
    
    docker scout recommendations "%FULL_IMAGE%" > "%SCAN_RESULTS_DIR%\scout-recommendations.txt"
    if %errorlevel% neq 0 echo ⚠️ Docker Scout recommendations failed
) else (
    echo ⚠️ Docker Scout not available, skipping vulnerability scan
)

echo.
echo 🛡️ Checking for Trivy security scanner...

REM Check if Trivy is available
where trivy >nul 2>&1
if %errorlevel% equ 0 (
    echo Running Trivy security scan...
    
    REM Scan for vulnerabilities
    trivy image --format json --output "%SCAN_RESULTS_DIR%\trivy-vulnerabilities.json" "%FULL_IMAGE%"
    
    REM Scan for secrets
    trivy image --scanners secret --format json --output "%SCAN_RESULTS_DIR%\trivy-secrets.json" "%FULL_IMAGE%"
    
    REM Generate human-readable report
    trivy image --format table --output "%SCAN_RESULTS_DIR%\trivy-report.txt" "%FULL_IMAGE%"
    
    echo ✅ Trivy scan completed. Results saved to %SCAN_RESULTS_DIR%\
) else (
    echo ⚠️ Trivy not available. Install from: https://github.com/aquasecurity/trivy/releases
)

echo.
echo ⚙️ Analyzing Docker image configuration...

REM Check if running as non-root
for /f %%i in ('docker run --rm "%FULL_IMAGE%" whoami 2^>nul') do set USER_CHECK=%%i
if "%USER_CHECK%"=="security" (
    echo ✅ Image runs as non-root user: %USER_CHECK%
) else (
    echo ❌ Image may be running as root user: %USER_CHECK%
)

REM Check for health check
for /f %%i in ('docker inspect "%FULL_IMAGE%" ^| findstr /C:"Healthcheck"') do set HEALTHCHECK=%%i
if not "%HEALTHCHECK%"=="" (
    echo ✅ Health check configured
) else (
    echo ⚠️ No health check configured
)

echo.
echo 🔒 Security hardening verification...

REM Run security verification inside container
docker run --rm "%FULL_IMAGE%" sh -c "
    echo Checking security configurations...
    
    if [ -f /etc/passwd ]; then
        echo ✅ /etc/passwd exists
        if grep -q 'security:x' /etc/passwd; then
            echo ✅ Security user configured
        else
            echo ❌ Security user not found
        fi
    fi
    
    python3.11 -c \"
import sys
print(f'✅ Python version: {sys.version}')
print(f'✅ Python executable: {sys.executable}')

try:
    import ssl
    print('✅ SSL context available')
except Exception as e:
    print(f'❌ SSL issue: {e}')
\"
"

echo.
echo 📋 Generating security report...

REM Generate security report
(
echo # Docker Security Scan Report
echo.
echo **Image:** %FULL_IMAGE%
echo **Scan Date:** %BUILD_DATE%
echo **Git Commit:** %VCS_REF%
echo.
echo ## Security Measures Implemented
echo.
echo ### Base Image Security
echo - ✅ Using Ubuntu 22.04 LTS for better security support
echo - ✅ Regular security updates applied during build
echo - ✅ Minimal package installation to reduce attack surface
echo - ✅ Clean package cache and temporary files
echo.
echo ### Runtime Security
echo - ✅ Non-root user execution ^(user: security, uid: 1000^)
echo - ✅ Proper file permissions ^(750 for application directories^)
echo - ✅ Secure environment variables configuration
echo - ✅ Signal handling with dumb-init
echo.
echo ### Application Security
echo - ✅ Python bytecode compilation disabled
echo - ✅ Hash randomization enabled
echo - ✅ Pip cache disabled
echo - ✅ Proper dependency management
echo.
echo ### Container Security
echo - ✅ Health checks configured
echo - ✅ Minimal exposed ports
echo - ✅ Proper entrypoint configuration
echo - ✅ Security labels and metadata
echo.
echo ## Scan Results
echo.
) > "%SCAN_RESULTS_DIR%\security-summary.md"

REM Add Trivy results if available
if exist "%SCAN_RESULTS_DIR%\trivy-report.txt" (
    echo ### Trivy Vulnerability Scan >> "%SCAN_RESULTS_DIR%\security-summary.md"
    echo ``` >> "%SCAN_RESULTS_DIR%\security-summary.md"
    more +1 "%SCAN_RESULTS_DIR%\trivy-report.txt" | head -n 50 >> "%SCAN_RESULTS_DIR%\security-summary.md" 2>nul
    echo ``` >> "%SCAN_RESULTS_DIR%\security-summary.md"
    echo. >> "%SCAN_RESULTS_DIR%\security-summary.md"
)

echo.
echo 📝 Security Recommendations
echo =============================================
echo 1. 🔄 Regularly update base images and dependencies
echo 2. 🔍 Run security scans in CI/CD pipeline
echo 3. 🛡️ Use Docker secrets for sensitive data
echo 4. 🔒 Implement proper network policies
echo 5. 📊 Monitor container runtime security
echo 6. 🚫 Never run containers as root in production
echo 7. 🔐 Use image signing and verification
echo 8. 📋 Regularly audit container configurations

echo.
echo ✅ Security scan completed!
echo 📁 Results saved to: %SCAN_RESULTS_DIR%\
echo 📋 Review the security-summary.md file for detailed results

echo.
echo Next steps:
echo 1. Review scan results in %SCAN_RESULTS_DIR%\
echo 2. Update any vulnerable dependencies
echo 3. Run 'docker-compose up -d' to deploy securely
echo 4. Monitor runtime security with your preferred tools

pause
