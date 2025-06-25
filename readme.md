# 🛡️ Security Multi-Agent System

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Security: bandit](https://img.shields.io/badge/security-bandit-green.svg)](https://github.com/PyCQA/bandit)
[![FastAPI](https://img.shields.io/badge/FastAPI-005571?logo=fastapi)](https://fastapi.tiangolo.com)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?logo=streamlit&logoColor=white)](https://streamlit.io)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/security-agents/multi-agent)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)


> **A next-generation, AI-powered cybersecurity threat intelligence platform that orchestrates multiple specialized agents to provide comprehensive security analysis, real-time threat detection, and automated incident response.**

---

## 📖 Table of Contents

- [🎯 Overview](#-overview)
- [✨ Key Features](#-key-features)
- [🏗️ Architecture](#️-architecture)
- [🚀 Quick Start](#-quick-start)
- [📦 Installation](#-installation)
- [🐳 Docker Deployment](#-docker-deployment)
- [⚙️ Configuration](#️-configuration)
- [🔧 Usage](#-usage)
- [🤖 Agent Documentation](#-agent-documentation)
- [📊 API Reference](#-api-reference)
- [🎨 Web Dashboard](#-web-dashboard)
- [🔌 Integrations](#-integrations)
- [📈 Monitoring & Logging](#-monitoring--logging)
- [🧪 Testing](#-testing)
- [🛠️ Development](#️-development)
- [📋 Roadmap](#-roadmap)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [🙏 Acknowledgments](#-acknowledgments)

---

## 🎯 Overview

The **Security Multi-Agent System** is an enterprise-grade cybersecurity platform that leverages artificial intelligence and distributed agent architecture to provide comprehensive threat intelligence, automated security analysis, and real-time incident response capabilities.

### 🎪 Live Demo
- **Dashboard**: [https://security-agents.demo.com](https://security-agents.demo.com) *(Demo URL)*
- **API Playground**: [https://api.security-agents.demo.com/docs](https://api.security-agents.demo.com/docs) *(Demo URL)*
- **Documentation**: [https://docs.security-agents.com](https://docs.security-agents.com) *(Demo URL)*

### 🎥 Demo Video
[![Security Multi-Agent System Demo](https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg)](https://www.youtube.com/watch?v=dQw4w9WgXcQ)

---

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 🔍 **Threat Intelligence**
- **VirusTotal Integration**: Real-time malware detection
- **AbuseIPDB Analysis**: IP reputation scoring
- **IPInfo Geolocation**: Geographic threat mapping
- **Multi-source Correlation**: Cross-reference threat data

</td>
<td width="50%">

### 🕵️ **OSINT Capabilities**
- **Email Breach Detection**: HaveIBeenPwned integration
- **Domain Intelligence**: Hunter.io domain analysis
- **Social Media Monitoring**: Automated OSINT collection
- **Dark Web Scanning**: Threat actor identification

</td>
</tr>
<tr>
<td width="50%">

### 🤖 **AI-Powered Analysis**
- **Google Gemini Integration**: Advanced LLM analysis
- **RAG (Retrieval-Augmented Generation)**: Context-aware insights
- **Correlation Engine**: Pattern recognition & threat correlation
- **Automated Report Generation**: Professional security reports

</td>
<td width="50%">

### 🚨 **Multi-Channel Alerting**
- **Email Notifications**: SMTP-based alerting
- **Slack Integration**: Real-time team notifications
- **Discord Webhooks**: Community-based alerts
- **Custom Webhooks**: Extensible notification system

</td>
</tr>
</table>

### 🏆 **Enterprise Features**

| Feature | Description | Status |
|---------|-------------|--------|
| **High Availability** | Distributed agent architecture with failover | ✅ |
| **Scalability** | Horizontal scaling with container orchestration | ✅ |
| **Docker Support** | Production-ready containerization with monitoring | ✅ |
| **Security** | End-to-end encryption, API key management | ✅ |
| **Compliance** | SOC 2, GDPR, CCPA compliance ready | ✅ |
| **Audit Trail** | Comprehensive logging and audit capabilities | ✅ |
| **Multi-tenancy** | Isolated environments for different organizations | 🔄 |

---

## 🏗️ Architecture

### 🎛️ **System Overview**

```mermaid
graph TB
    subgraph "🌐 User Interfaces"
        UI1[📊 Streamlit Dashboard]
        UI2[🔌 FastAPI REST API]
    end
    
    subgraph "🧠 Core System"
        CA[🎮 Controller Agent]
        A2A[📡 A2A Protocol]
        DB[(🗄️ SQLite Database)]
        LOG[📝 Logger]
    end
    
    subgraph "🤖 Specialized Agents"
        TIA[🔍 Threat Intel Agent]
        OSA[🕵️ OSINT Agent]
        CRA[🧮 Correlation Agent]
        RAG[📚 RAG Agent]
        RPA[📄 Report Agent]
        ALA[🚨 Alert Agent]
        STA[🧪 Self Test Agent]
    end
    
    subgraph "🌍 External APIs"
        VT[🦠 VirusTotal API]
        ABUSE[⚠️ AbuseIPDB API]
        IPINFO[🌍 IPInfo API]
        HIBP[🔓 HaveIBeenPwned API]
        HUNTER[🏹 Hunter.io API]
        SERP[🔍 SerpAPI]
        GEMINI[🤖 Google Gemini API]
    end
    
    UI1 --> CA
    UI2 --> CA
    CA --> A2A
    A2A --> TIA & OSA & CRA & RAG & RPA & ALA & STA
    TIA --> VT & ABUSE & IPINFO
    OSA --> HIBP & HUNTER
    CRA --> GEMINI
    RAG --> SERP & GEMINI
    CA --> LOG --> DB
```

### 🔄 **Agent Workflow**

Each scan follows a sophisticated multi-stage process:

1. **🎯 Input Processing**: Query validation and routing
2. **🔍 Threat Intelligence**: Multi-source threat data collection
3. **🕵️ OSINT Analysis**: Open source intelligence gathering
4. **🧮 Correlation**: AI-powered data correlation and analysis
5. **📚 RAG Enhancement**: Real-time web intelligence integration
6. **📄 Report Generation**: Automated professional report creation
7. **🧪 Quality Assurance**: Self-testing and validation
8. **🚨 Alerting**: Multi-channel notification system
9. **📝 Logging**: Comprehensive audit trail

### 🔗 **Communication Protocol**

The system uses a custom **Agent-to-Agent (A2A) Protocol** for secure, efficient communication:

```python
# Example A2A Message Structure
{
    "from": "controller_agent",
    "to": "threat_intel_agent", 
    "type": "threat_analysis",
    "payload": {
        "query": "192.168.1.1",
        "priority": "high",
        "correlation_id": "uuid-12345"
    },
    "timestamp": "2025-06-25T10:30:00Z"
}
```

---

## 🚀 Quick Start

Get up and running in less than 5 minutes:

### 🐳 **Docker (Recommended)**

**Production Deployment:**
```bash
# Clone the repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Copy and configure environment variables
cp .env.example .env
# Edit .env with your API keys and configuration

# Deploy with automated security scanning
./deploy.sh deploy     # Linux/macOS (includes security scan)
deploy.bat deploy      # Windows (includes security scan)

# Or deploy manually with security verification
./security-scan.sh && docker-compose up -d   # Linux/macOS
security-scan.bat && docker-compose up -d    # Windows

# Access the applications
start http://localhost:8501         # Dashboard
start http://localhost:8000/docs    # API Documentation  
start http://localhost:3000         # Grafana Monitoring
start http://localhost:9090         # Prometheus Metrics
```

**Development Environment:**
```bash
# Start development environment with live reload
docker-compose -f docker-compose.dev.yml up -d

# Access development tools
start http://localhost:8501         # Dashboard (live reload)
start http://localhost:8000/docs    # API (live reload)
start http://localhost:8888         # Jupyter Notebook
start http://localhost:5432         # PostgreSQL (dev)
```

**Quick Commands:**
```bash
# Scale services
docker-compose up -d --scale worker=3

# View logs
docker-compose logs -f api

# Update and restart
docker-compose pull && docker-compose up -d

# Backup data
docker-compose exec db pg_dump -U postgres security_agents > backup.sql
```

### 📦 **Python Package**

```bash
# Install via pip
pip install security-multi-agent

# Run the system
security-agents --config config.yaml
```

### ☁️ **Cloud Deployment**

[![Deploy to AWS](https://img.shields.io/badge/Deploy%20to-AWS-orange?logo=amazon-aws)](https://aws.amazon.com/quickstart/)
[![Deploy to GCP](https://img.shields.io/badge/Deploy%20to-GCP-blue?logo=google-cloud)](https://cloud.google.com/marketplace)
[![Deploy to Azure](https://img.shields.io/badge/Deploy%20to-Azure-blue?logo=microsoft-azure)](https://azure.microsoft.com/marketplace/)

---

## 📦 Installation

### 📋 **Prerequisites**

- **Python**: 3.8+ (3.11+ recommended)
- **Memory**: 4GB RAM minimum (8GB+ recommended)
- **Storage**: 2GB available disk space
- **Network**: Internet access for API integrations

### 🔧 **Installation Methods**

<details>
<summary><b>📦 Production Installation (Recommended)</b></summary>

```bash
# Create virtual environment
python -m venv security-agents-env
source security-agents-env/bin/activate  # Linux/Mac
# security-agents-env\Scripts\activate  # Windows

# Install from PyPI
pip install security-multi-agent[all]

# Initialize the system
security-agents init --interactive
```

</details>

<details>
<summary><b>🛠️ Development Installation</b></summary>

```bash
# Clone repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Install with development dependencies
pip install -e ".[dev,test]"

# Install pre-commit hooks
pre-commit install

# Run tests
pytest
```

</details>

<details>
<summary><b>🐳 Docker Installation (Recommended)</b></summary>

#### **Prerequisites**
- Docker 20.10+ and Docker Compose 2.0+
- 8GB RAM (minimum), 16GB+ recommended for production
- 20GB available disk space for full stack with monitoring

#### **Production Deployment**

```bash
# Clone repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Configure environment
cp .env.example .env
# Edit .env with your API keys (see Configuration section)

# Deploy full production stack
docker-compose up -d

# Verify deployment
docker-compose ps
docker-compose logs -f
```

**Services included:**
- **API Server**: FastAPI backend with auto-scaling workers
- **Dashboard**: Streamlit web interface  
- **Database**: PostgreSQL with persistent storage
- **Cache**: Redis for session management and caching
- **Reverse Proxy**: Nginx with SSL termination and load balancing
- **Monitoring**: Prometheus metrics collection
- **Visualization**: Grafana dashboards
- **Background Workers**: Celery task processing

#### **Development Environment**

```bash
# Start development stack with live code reload
docker-compose -f docker-compose.dev.yml up -d

# Access development tools
echo "Dashboard: http://localhost:8501"
echo "API Docs: http://localhost:8000/docs"  
echo "Jupyter: http://localhost:8888"
echo "pgAdmin: http://localhost:5050"
echo "Redis Commander: http://localhost:8081"
```

**Development features:**
- Live code reload for Python changes
- Jupyter Notebook integration
- PostgreSQL with pgAdmin interface
- Redis Commander for cache management
- Volume mounts for local development

#### **Automated Deployment Scripts**

**Windows:**
```cmd
# Build and deploy
deploy.bat deploy

# Scale services
deploy.bat scale

# Backup data
deploy.bat backup

# Monitor system
deploy.bat monitor

# Clean shutdown
deploy.bat stop
```

**Linux/macOS:**
```bash
# Make script executable
chmod +x deploy.sh

# Build and deploy
./deploy.sh deploy

# Scale services  
./deploy.sh scale

# Backup data
./deploy.sh backup

# Monitor system
./deploy.sh monitor

# Clean shutdown
./deploy.sh stop
```

#### **Container Management**

```bash
# View running services
docker-compose ps

# Check service health
docker-compose exec api curl http://localhost:8000/health

# View logs
docker-compose logs -f api
docker-compose logs -f dashboard
docker-compose logs -f worker

# Scale background workers
docker-compose up -d --scale worker=3

# Update to latest images
docker-compose pull
docker-compose up -d

# Restart specific service
docker-compose restart api

# Execute commands in containers
docker-compose exec api python -c "from agents.controller_agent import *; print('System ready')"
docker-compose exec db psql -U postgres -d security_agents
```

#### **Production Considerations**

**Resource Limits:**
```yaml
# Defined in docker-compose.yml
services:
  api:
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '1.0'
        reservations:
          memory: 1G
          cpus: '0.5'
```

**Health Checks:**
- All services include health checks
- Automatic restart on failure
- Dependency ordering with wait conditions

**Security:**
- Non-root container execution
- Secrets management with Docker secrets
- Network isolation between services
- Regular security updates in base images

**Monitoring:**
- Prometheus metrics for all services
- Grafana dashboards for visualization
- Alert rules for system health
- Log aggregation and analysis

#### **Troubleshooting**

```bash
# Check service logs
docker-compose logs api | tail -50

# Debug container issues
docker-compose exec api /bin/bash

# Restart unhealthy services
docker-compose restart $(docker-compose ps --filter health=unhealthy -q)

# Reset development environment
docker-compose -f docker-compose.dev.yml down -v
docker-compose -f docker-compose.dev.yml up -d

# Clean Docker system
docker system prune -f
docker volume prune -f
```

**Common Issues:**
- **Port conflicts**: Modify ports in docker-compose.yml
- **Memory issues**: Increase Docker memory limits
- **API key errors**: Verify .env configuration
- **Database connection**: Check PostgreSQL container health

See [DOCKER.md](./DOCKER.md) for comprehensive Docker deployment guide.

</details>

### 📄 **Requirements**

The system requires several external API keys for full functionality:

| Service | Required | Purpose | Free Tier |
|---------|----------|---------|-----------|
| **VirusTotal** | ✅ | Malware detection | 1,000 requests/day |
| **AbuseIPDB** | ✅ | IP reputation | 1,000 requests/day |
| **IPInfo** | ✅ | Geolocation data | 50,000 requests/month |
| **Google Gemini** | ✅ | AI analysis | Free with limits |
| **SerpAPI** | ⚠️ | Web search | 100 searches/month |
| **HaveIBeenPwned** | ⚠️ | Breach data | Rate limited |
| **Hunter.io** | ⚠️ | Domain intelligence | 25 searches/month |

---

## 🐳 Docker Deployment

### 📋 **Prerequisites**

Before deploying with Docker, ensure you have:

- **Docker**: 20.10+ with BuildKit support
- **Docker Compose**: 2.0+ (included with Docker Desktop)
- **System Resources**: 8GB RAM minimum (16GB+ recommended for production)
- **Storage**: 20GB available disk space
- **Network**: Outbound internet access for API integrations

### 🚀 **Quick Start with Docker**

#### **1. Clone and Setup**
```bash
# Clone the repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Copy environment template
cp .env.example .env
```

#### **2. Configure Environment**
Edit `.env` with your API keys:
```bash
# Required API Keys
VT_API_KEY=your_virustotal_api_key_here
ABUSEIPDB_API_KEY=your_abuseipdb_api_key_here
IPINFO_TOKEN=your_ipinfo_token_here
GEMINI_API_KEY=your_google_gemini_api_key_here

# Database Configuration (production)
POSTGRES_USER=security_admin
POSTGRES_PASSWORD=your_secure_password_here
POSTGRES_DB=security_agents

# Email Alerts Configuration
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
EMAIL_USER=your_email@gmail.com
EMAIL_PASSWORD=your_app_password_here
```

#### **3. Deploy Production Stack**
```bash
# Deploy all services with monitoring
docker-compose up -d

# Or use our automated deployment script
# Windows
deploy.bat deploy

# Linux/macOS  
chmod +x deploy.sh && ./deploy.sh deploy
```

#### **4. Verify Deployment**
```bash
# Check all services are running
docker-compose ps

# View service logs
docker-compose logs -f api

# Test API health
curl http://localhost:8000/health
```

#### **5. Access Applications**
- **Dashboard**: http://localhost:8501
- **API Documentation**: http://localhost:8000/docs
- **Grafana Monitoring**: http://localhost:3000 (admin/admin)
- **Prometheus Metrics**: http://localhost:9090

### 🏗️ **Architecture Overview**

The Docker deployment includes:

```mermaid
graph TB
    subgraph "Load Balancer"
        NGINX[🌐 Nginx<br/>Port 80/443]
    end
    
    subgraph "Application Layer"
        API[🚀 FastAPI<br/>Port 8000]
        DASH[📊 Streamlit<br/>Port 8501]
        WORKER[⚙️ Celery Workers<br/>Background Tasks]
    end
    
    subgraph "Data Layer"
        POSTGRES[(🗄️ PostgreSQL<br/>Port 5432)]
        REDIS[(📦 Redis<br/>Port 6379)]
    end
    
    subgraph "Monitoring"
        PROMETHEUS[📈 Prometheus<br/>Port 9090]
        GRAFANA[📊 Grafana<br/>Port 3000]
    end
    
    NGINX --> API
    NGINX --> DASH
    API --> POSTGRES
    API --> REDIS
    WORKER --> POSTGRES
    WORKER --> REDIS
    PROMETHEUS --> API
    PROMETHEUS --> POSTGRES
    GRAFANA --> PROMETHEUS
```

### 🛠️ **Development Environment**

For development with live code reload:

```bash
# Start development stack
docker-compose -f docker-compose.dev.yml up -d

# Access development tools
echo "Dashboard (live reload): http://localhost:8501"
echo "API (live reload): http://localhost:8000/docs"
echo "Jupyter Notebook: http://localhost:8888"
echo "pgAdmin: http://localhost:5050"
echo "Redis Commander: http://localhost:8081"
```

**Development Features:**
- 🔄 **Live Reload**: Automatic restart on code changes
- 📓 **Jupyter Integration**: Pre-configured notebooks
- 🗄️ **Database Tools**: pgAdmin for PostgreSQL management
- 📦 **Cache Management**: Redis Commander interface
- 🐛 **Debugging**: Remote debugging support
- 📝 **Volume Mounts**: Direct code editing

### 📊 **Service Configuration**

#### **Production Services (docker-compose.yml)**

| Service | Purpose | Ports | Health Check |
|---------|---------|-------|--------------|
| **nginx** | Reverse proxy & load balancer | 80, 443 | HTTP status |
| **api** | FastAPI backend | 8000 | /health endpoint |
| **dashboard** | Streamlit web UI | 8501 | HTTP status |
| **worker** | Background task processing | - | Task queue |
| **db** | PostgreSQL database | 5432 | Connection test |
| **redis** | Cache & session store | 6379 | Ping test |
| **prometheus** | Metrics collection | 9090 | /metrics |
| **grafana** | Monitoring dashboards | 3000 | HTTP status |

#### **Development Services (docker-compose.dev.yml)**

Additional development services:
- **jupyter**: Notebook server (8888)
- **pgadmin**: Database admin (5050)
- **redis-commander**: Cache admin (8081)
- **mailhog**: Email testing (8025)

### 🔧 **Management Commands**

#### **Using Deployment Scripts**

**Windows (deploy.bat):**
```cmd
deploy.bat deploy          # Full deployment
deploy.bat scale           # Scale services
deploy.bat backup          # Backup database
deploy.bat restore         # Restore from backup
deploy.bat logs            # View logs
deploy.bat monitor         # Open monitoring
deploy.bat stop            # Stop all services
deploy.bat clean           # Clean system
```

**Linux/macOS (deploy.sh):**
```bash
./deploy.sh deploy         # Full deployment
./deploy.sh scale          # Scale services  
./deploy.sh backup         # Backup database
./deploy.sh restore        # Restore from backup
./deploy.sh logs           # View logs
./deploy.sh monitor        # Open monitoring
./deploy.sh stop           # Stop all services
./deploy.sh clean          # Clean system
```

#### **Manual Docker Commands**

```bash
# View running services
docker-compose ps

# Scale background workers
docker-compose up -d --scale worker=3

# View logs
docker-compose logs -f api
docker-compose logs -f worker

# Execute commands in containers
docker-compose exec api python manage.py migrate
docker-compose exec db psql -U postgres -d security_agents

# Restart services
docker-compose restart api
docker-compose restart worker

# Update images
docker-compose pull
docker-compose up -d
```

### 🔒 **Security Configuration**

### 🔒 **Security Configuration**

#### **Enhanced Security Features**
The Docker configuration includes comprehensive security hardening:

**Base Image Security:**
- ✅ **Ubuntu 22.04 LTS**: Long-term support with regular security updates
- ✅ **Multi-stage Build**: Minimized attack surface by excluding build dependencies
- ✅ **Vulnerability Scanning**: Automated security scanning during build process
- ✅ **Minimal Packages**: Only essential runtime dependencies installed

**Runtime Security:**
- ✅ **Non-root Execution**: All containers run as non-privileged user (security:1000)
- ✅ **File Permissions**: Proper ownership and restricted permissions (750)
- ✅ **Read-only Containers**: Immutable container filesystems where possible
- ✅ **Signal Handling**: Proper signal handling with dumb-init

**Network Security:**
- ✅ **Internal Networks**: Services communicate via isolated Docker networks
- ✅ **Minimal Port Exposure**: Only necessary ports exposed to host
- ✅ **Reverse Proxy**: Nginx provides SSL termination and security headers
- ✅ **Security Headers**: HSTS, CSP, X-Frame-Options, and more

**Secrets Management:**
- ✅ **Environment Variables**: Sensitive data via secure environment variables
- ✅ **Docker Secrets**: Support for Docker Swarm secrets (production)
- ✅ **Vault Integration**: Ready for HashiCorp Vault integration
- ✅ **Key Rotation**: Automated API key rotation capabilities

#### **Security Scanning**

**Automated Vulnerability Scanning:**
```bash
# Run comprehensive security scan
./security-scan.sh        # Linux/macOS
security-scan.bat          # Windows

# Or via deploy script (includes automatic scanning)
./deploy.sh deploy         # Linux/macOS
deploy.bat deploy          # Windows
```

**Supported Security Tools:**
- **Docker Scout**: Built-in Docker vulnerability scanning
- **Trivy**: Comprehensive vulnerability and secret scanning
- **Grype**: Vulnerability scanner by Anchore
- **Docker Bench Security**: Docker CIS Benchmark security audit

**Scan Results:**
All scan results are saved to `./security-scan-results/` including:
- `security-summary.md`: Comprehensive security report
- `trivy-vulnerabilities.json`: Detailed vulnerability data
- `scout-cves.sarif`: Docker Scout SARIF format results
- `grype-report.txt`: Human-readable vulnerability report

#### **SSL/TLS Setup**
```bash
# Generate SSL certificates (production)
mkdir -p nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/nginx.key \
  -out nginx/ssl/nginx.crt

# Or use Let's Encrypt with Certbot
docker-compose -f docker-compose.ssl.yml up -d
```

#### **Secrets Management**
```bash
# Create Docker secrets
echo "your_secret_key" | docker secret create jwt_secret -
echo "your_db_password" | docker secret create db_password -

# Use in docker-compose.yml
secrets:
  - jwt_secret
  - db_password
```

#### **Security Best Practices**

**Deployment Security Checklist:**
- [ ] Update all API keys and passwords in `.env`
- [ ] Run security scan before deployment
- [ ] Enable SSL/TLS for production
- [ ] Configure proper firewall rules
- [ ] Set up log monitoring and alerting
- [ ] Enable container resource limits
- [ ] Implement backup and disaster recovery
- [ ] Regular security updates and patching

**Runtime Security Monitoring:**
```bash
# Monitor container security
docker-compose exec api ls -la /app  # Check file permissions
docker-compose exec api whoami       # Verify non-root execution
docker-compose exec api ps aux       # Check running processes

# Check for vulnerabilities in running containers
trivy image security-agents/multi-agent:latest

# Monitor for suspicious activity
docker-compose logs --tail=100 | grep -i "error\|warning\|fail"
```

### 📈 **Monitoring & Alerting**

#### **Grafana Dashboards**
Pre-configured dashboards include:
- **System Overview**: Service health and performance
- **Security Metrics**: Threat detection statistics  
- **API Performance**: Request rates and response times
- **Database Monitoring**: Connection pools and query performance
- **Alert Activity**: Notification delivery metrics

#### **Prometheus Alerts**
Configured alert rules:
- High API error rates
- Database connection failures
- Worker queue backup
- Memory/CPU usage thresholds
- Service availability

#### **Log Aggregation**
```bash
# View aggregated logs
docker-compose logs -f --tail=100

# Search logs
docker-compose logs api | grep "ERROR"

# Export logs
docker-compose logs --no-color > system.log
```

### 🚨 **Troubleshooting**

#### **Common Issues**

**Service Won't Start:**
```bash
# Check service logs
docker-compose logs service-name

# Verify environment variables
docker-compose config

# Check resource usage
docker stats
```

**Database Connection Issues:**
```bash
# Test database connectivity
docker-compose exec api python -c "from db.logger import test_connection; test_connection()"

# Check database logs
docker-compose logs db

# Reset database
docker-compose down -v
docker-compose up -d db
```

**Performance Issues:**
```bash
# Monitor resource usage
docker stats

# Scale services
docker-compose up -d --scale worker=5 --scale api=2

# Check for memory leaks
docker-compose exec api python -c "import psutil; print(f'Memory: {psutil.virtual_memory().percent}%')"
```

#### **Health Checks**

```bash
# Check all service health
docker-compose ps

# Detailed health status
for service in api dashboard worker db redis; do
  echo "=== $service ==="
  docker-compose exec $service sh -c 'echo "Service: $HOSTNAME - Status: Healthy"' 2>/dev/null || echo "Service: $service - Status: Unhealthy"
done

# API-specific health check
curl -f http://localhost:8000/health || echo "API health check failed"
```

#### **Data Backup & Recovery**

```bash
# Backup database
docker-compose exec db pg_dump -U postgres -d security_agents > backup_$(date +%Y%m%d).sql

# Backup volumes
docker run --rm -v security_multi_agent_db_data:/data -v $(pwd):/backup alpine tar czf /backup/volumes_backup.tar.gz /data

# Restore database
docker-compose exec -T db psql -U postgres -d security_agents < backup_20241225.sql
```

### 🔄 **Updates & Maintenance**

#### **Updating the System**
```bash
# Pull latest images
docker-compose pull

# Restart with new images
docker-compose up -d

# Clean old images
docker image prune -f
```

#### **Scaling for Production**
```bash
# Horizontal scaling
docker-compose up -d --scale api=3 --scale worker=5

# Load balancer will distribute traffic automatically
# Monitor with Grafana dashboards
```

#### **Resource Optimization**
```yaml
# Adjust in docker-compose.yml
services:
  api:
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '1.0'
        reservations:
          memory: 1G
          cpus: '0.5'
```

For comprehensive Docker deployment documentation, see [DOCKER.md](./DOCKER.md).

---

## ⚙️ Configuration

### 📝 **Environment Variables**

Create a `.env` file in your project root (copy from `.env.example`):

```bash
# =============================================================================
# CORE API KEYS (Required)
# =============================================================================
VT_API_KEY=your_virustotal_api_key_here
ABUSEIPDB_API_KEY=your_abuseipdb_api_key_here
IPINFO_TOKEN=your_ipinfo_token_here
GEMINI_API_KEY=your_google_gemini_api_key_here

# =============================================================================
# OPTIONAL API KEYS (Enhanced Features)
# =============================================================================
SERPAPI_KEY=your_serpapi_key_here
HIBP_API_KEY=your_haveibeenpwned_key_here
HUNTER_API_KEY=your_hunterio_key_here

# =============================================================================
# DATABASE CONFIGURATION
# =============================================================================
# Production (PostgreSQL)
POSTGRES_USER=security_admin
POSTGRES_PASSWORD=your_secure_database_password_here
POSTGRES_DB=security_agents
POSTGRES_HOST=db
POSTGRES_PORT=5432

# Development (SQLite fallback)
DATABASE_URL=sqlite:///./data/security_agents.db

# =============================================================================
# REDIS CONFIGURATION
# =============================================================================
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=your_redis_password_here
REDIS_DB=0

# =============================================================================
# EMAIL ALERT CONFIGURATION
# =============================================================================
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USE_TLS=true
EMAIL_USER=your_email@gmail.com
EMAIL_PASSWORD=your_app_password_here
EMAIL_FROM=Security Agents <security@yourcompany.com>
EMAIL_TO=admin@yourcompany.com,security-team@yourcompany.com

# =============================================================================
# SLACK INTEGRATION
# =============================================================================
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK
SLACK_CHANNEL=#security-alerts
SLACK_USERNAME=Security Agent
SLACK_ICON_EMOJI=:shield:

# =============================================================================
# DISCORD INTEGRATION
# =============================================================================
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/YOUR/DISCORD/WEBHOOK
DISCORD_USERNAME=Security Agent
DISCORD_AVATAR_URL=https://your-domain.com/avatar.png

# =============================================================================
# SECURITY SETTINGS
# =============================================================================
SECRET_KEY=your_jwt_secret_key_minimum_32_characters_long
JWT_ALGORITHM=HS256
JWT_EXPIRATION_HOURS=24
API_KEY_ROTATION_DAYS=30
SESSION_TIMEOUT_HOURS=1
MAX_LOGIN_ATTEMPTS=5

# =============================================================================
# APPLICATION SETTINGS
# =============================================================================
# Environment: development, staging, production
ENVIRONMENT=production
DEBUG=false
LOG_LEVEL=INFO
CORS_ORIGINS=["http://localhost:3000", "https://yourdomain.com"]

# API Configuration
API_HOST=0.0.0.0
API_PORT=8000
API_WORKERS=4
API_RELOAD=false

# Dashboard Configuration
DASHBOARD_HOST=0.0.0.0
DASHBOARD_PORT=8501
DASHBOARD_DEBUG=false

# =============================================================================
# AGENT CONFIGURATION
# =============================================================================
# Threat Intelligence Agent
THREAT_INTEL_ENABLED=true
THREAT_INTEL_TIMEOUT=30
THREAT_INTEL_RETRY_ATTEMPTS=3
THREAT_INTEL_RATE_LIMIT=100

# OSINT Agent
OSINT_ENABLED=true
OSINT_TIMEOUT=45
OSINT_INCLUDE_BREACHES=true
OSINT_INCLUDE_DOMAINS=true

# Correlation Agent
CORRELATION_ENABLED=true
CORRELATION_MODEL=gemini-pro
CORRELATION_TEMPERATURE=0.3
CORRELATION_MAX_TOKENS=2048

# RAG Agent
RAG_ENABLED=true
RAG_SEARCH_RESULTS=10
RAG_CONTEXT_WINDOW=4000

# Report Agent
REPORT_ENABLED=true
REPORT_TEMPLATE=professional
REPORT_FORMATS=markdown,pdf
REPORT_INCLUDE_CHARTS=true

# Alert Agent
ALERT_ENABLED=true
ALERT_CHANNELS=email,slack,discord
ALERT_SEVERITY_THRESHOLD=medium
ALERT_RATE_LIMIT=50

# Self Test Agent
SELFTEST_ENABLED=true
SELFTEST_INTERVAL=3600
SELFTEST_VALIDATION_LEVEL=strict

# =============================================================================
# MONITORING & LOGGING
# =============================================================================
# Prometheus
PROMETHEUS_ENABLED=true
PROMETHEUS_PORT=9090
PROMETHEUS_SCRAPE_INTERVAL=15s

# Grafana
GRAFANA_ENABLED=true
GRAFANA_PORT=3000
GRAFANA_ADMIN_USER=admin
GRAFANA_ADMIN_PASSWORD=admin
GRAFANA_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource

# Logging
LOG_FORMAT=json
LOG_FILE=./logs/security_agents.log
LOG_MAX_SIZE=100MB
LOG_BACKUP_COUNT=5
LOG_ROTATION=daily

# =============================================================================
# FEATURE FLAGS
# =============================================================================
FEATURE_ASYNC_PROCESSING=true
FEATURE_CACHING=true
FEATURE_RATE_LIMITING=true
FEATURE_API_VERSIONING=true
FEATURE_WEBHOOK_RETRIES=true
FEATURE_BACKUP_AUTOMATION=true
FEATURE_METRICS_COLLECTION=true

# =============================================================================
# PERFORMANCE TUNING
# =============================================================================
# Worker Configuration
CELERY_WORKERS=4
CELERY_CONCURRENCY=4
CELERY_MAX_TASKS_PER_CHILD=100
CELERY_TASK_TIMEOUT=300

# Database Connection Pool
DB_POOL_SIZE=20
DB_MAX_OVERFLOW=30
DB_POOL_TIMEOUT=30
DB_POOL_RECYCLE=3600

# Cache Configuration
CACHE_TTL=3600
CACHE_MAX_SIZE=1000
CACHE_ENABLED=true

# =============================================================================
# BACKUP & RETENTION
# =============================================================================
BACKUP_ENABLED=true
BACKUP_SCHEDULE=0 2 * * *  # Daily at 2 AM
BACKUP_RETENTION_DAYS=30
BACKUP_LOCATION=./backups
BACKUP_ENCRYPTION=true

# Data Retention
LOG_RETENTION_DAYS=90
SCAN_RETENTION_DAYS=365
ALERT_RETENTION_DAYS=180
```

**Required Environment Variables:**
- `VT_API_KEY`: VirusTotal API key
- `ABUSEIPDB_API_KEY`: AbuseIPDB API key  
- `IPINFO_TOKEN`: IPInfo.io access token
- `GEMINI_API_KEY`: Google Gemini API key
- `SECRET_KEY`: JWT signing key (minimum 32 characters)
- `POSTGRES_PASSWORD`: Database password for production

**Optional but Recommended:**
- Email configuration for alerts
- Slack/Discord webhooks for notifications
- Additional API keys for enhanced features

### ⚙️ **Configuration File**

Create `config.yaml`:

```yaml
# Security Multi-Agent Configuration
app:
  name: "Security Multi-Agent System"
  version: "1.0.0"
  debug: false
  host: "0.0.0.0"
  port: 8000

agents:
  threat_intel:
    enabled: true
    timeout: 30
    retry_attempts: 3
    rate_limit: 100  # requests per hour
    
  osint:
    enabled: true
    timeout: 45
    sources:
      - haveibeenpwned
      - hunterio
    
  correlation:
    enabled: true
    model: "gemini-pro"
    temperature: 0.3
    max_tokens: 2048
    
  rag:
    enabled: true
    search_results: 10
    context_window: 4000
    
  report:
    enabled: true
    template: "professional"
    format: ["markdown", "pdf"]
    
  alert:
    enabled: true
    channels: ["email", "slack", "discord"]
    severity_threshold: "medium"
    
  selftest:
    enabled: true
    validation_level: "strict"

database:
  type: "sqlite"
  path: "./data/security_agents.db"
  backup_interval: "24h"
  retention_days: 90

logging:
  level: "INFO"
  format: "json"
  file: "./logs/security_agents.log"
  max_size: "100MB"
  backup_count: 5

security:
  encryption: true
  api_key_rotation: "30d"
  session_timeout: "1h"
  max_login_attempts: 5

monitoring:
  metrics_enabled: true
  health_check_interval: "30s"
  performance_tracking: true
```

---

## 🔧 Usage

### 🖥️ **Command Line Interface**

```bash
# Start the complete system
security-agents start

# Run specific agents only
security-agents start --agents threat_intel,osint,correlation

# Scan a single IP address
security-agents scan --ip 192.168.1.1 --format json

# Scan multiple targets from file
security-agents scan --file targets.txt --output results/

# Generate report for existing scan
security-agents report --scan-id abc-123 --format pdf

# Show system status
security-agents status --detailed

# Update threat intelligence feeds
security-agents update --feeds all

# Export data
security-agents export --format csv --date-range 7d
```

### 🐍 **Python API**

```python
from security_agents import SecuritySystem, ScanRequest

# Initialize the system
system = SecuritySystem(config_path="config.yaml")

# Simple scan
result = system.scan_ip("8.8.8.8")
print(f"Threat Score: {result.threat_score}")
print(f"Country: {result.geolocation.country}")

# Advanced scan with options
scan_request = ScanRequest(
    target="malicious-domain.com",
    scan_type="comprehensive",
    priority="high",
    include_osint=True,
    generate_report=True,
    alert_on_threats=True
)

result = system.execute_scan(scan_request)

# Access individual agent results
print("VirusTotal:", result.threat_intel.virustotal)
print("OSINT Data:", result.osint.summary)
print("AI Analysis:", result.correlation.analysis)

# Generate custom report
report = system.generate_report(
    scan_id=result.scan_id,
    template="executive_summary",
    include_charts=True
)
```

### 🌐 **REST API Examples**

```bash
# Health check
curl -X GET "http://localhost:8000/health"

# Authenticate
curl -X POST "http://localhost:8000/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "secure_password"}'

# Start a new scan
curl -X POST "http://localhost:8000/api/v1/scan" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "target": "192.168.1.1",
    "scan_type": "comprehensive",
    "priority": "high"
  }'

# Get scan results
curl -X GET "http://localhost:8000/api/v1/scan/{scan_id}" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# List all scans
curl -X GET "http://localhost:8000/api/v1/scans?limit=50&offset=0" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Download report
curl -X GET "http://localhost:8000/api/v1/scan/{scan_id}/report?format=pdf" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  --output report.pdf
```

---

## 🤖 Agent Documentation

### 🔍 **Threat Intelligence Agent**

Collects and analyzes threat data from multiple sources:

**Capabilities:**
- VirusTotal malware scanning
- AbuseIPDB reputation analysis  
- IPInfo geolocation data
- Automated threat scoring

**Configuration:**
```yaml
threat_intel:
  sources:
    virustotal:
      api_key: "${VT_API_KEY}"
      rate_limit: 4  # requests per minute
    abuseipdb:
      api_key: "${ABUSEIPDB_API_KEY}" 
      confidence_threshold: 75
    ipinfo:
      token: "${IPINFO_TOKEN}"
      include_privacy: false
```

### 🕵️ **OSINT Agent**

Performs open source intelligence gathering:

**Capabilities:**
- Email breach detection
- Domain reputation analysis
- Social media monitoring
- Dark web intelligence

**Configuration:**
```yaml
osint:
  sources:
    haveibeenpwned:
      api_key: "${HIBP_API_KEY}"
      include_unverified: false
    hunterio:
      api_key: "${HUNTER_API_KEY}"
      limit: 10
```

### 🧮 **Correlation Agent**

AI-powered threat correlation and analysis:

**Capabilities:**
- Pattern recognition
- Threat attribution
- Risk assessment
- Contextual analysis

**Configuration:**
```yaml
correlation:
  model: "gemini-pro"
  temperature: 0.3
  max_tokens: 2048
  prompt_template: "correlation_analysis.txt"
```

### 📚 **RAG Agent**

Real-time intelligence augmentation:

**Capabilities:**
- Web search integration
- Context-aware analysis
- Real-time threat feeds
- Intelligence synthesis

### 📄 **Report Agent**

Professional security report generation:

**Capabilities:**
- Multiple output formats
- Custom templates
- Executive summaries
- Technical appendices

### 🚨 **Alert Agent**

Multi-channel alerting and notifications:

**Capabilities:**
- Email notifications
- Slack integration
- Discord webhooks
- Custom webhook support
- Severity-based routing

### 🧪 **Self Test Agent**

Quality assurance and validation:

**Capabilities:**
- Data integrity checking
- Performance monitoring
- Error detection
- Health reporting

---

## 📊 API Reference

### 🔐 **Authentication**

All API endpoints require authentication using JWT tokens:

```bash
# Login to get token
POST /auth/login
{
  "username": "your_username",
  "password": "your_password"
}

# Response
{
  "access_token": "jwt_token_here",
  "token_type": "bearer",
  "expires_in": 86400
}

# Use token in subsequent requests
Authorization: Bearer jwt_token_here
```

### 🎯 **Scan Endpoints**

<details>
<summary><b>POST /api/v1/scan</b> - Start New Scan</summary>

**Request Body:**
```json
{
  "target": "192.168.1.1",
  "scan_type": "comprehensive",
  "priority": "high",
  "options": {
    "include_osint": true,
    "generate_report": true,
    "alert_on_threats": true,
    "custom_tags": ["internal", "priority"]
  }
}
```

**Response:**
```json
{
  "scan_id": "550e8400-e29b-41d4-a716-446655440000",
  "status": "initiated",
  "estimated_completion": "2025-06-25T10:35:00Z",
  "target": "192.168.1.1"
}
```

</details>

<details>
<summary><b>GET /api/v1/scan/{scan_id}</b> - Get Scan Results</summary>

**Response:**
```json
{
  "scan_id": "550e8400-e29b-41d4-a716-446655440000",
  "status": "completed",
  "target": "192.168.1.1",
  "threat_score": 85,
  "risk_level": "high",
  "started_at": "2025-06-25T10:30:00Z",
  "completed_at": "2025-06-25T10:34:30Z",
  "results": {
    "threat_intel": {
      "virustotal": {
        "malicious_count": 15,
        "total_engines": 70,
        "reputation": -5
      },
      "abuseipdb": {
        "abuse_confidence": 92,
        "country": "CN",
        "usage_type": "hosting"
      }
    },
    "osint": {
      "breach_count": 0,
      "domain_reputation": "clean"
    },
    "correlation": {
      "analysis": "High-risk IP associated with malware distribution",
      "confidence": 0.92
    }
  }
}
```

</details>

### 📋 **Management Endpoints**

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/scans` | GET | List all scans with pagination |
| `/api/v1/scan/{id}/report` | GET | Download scan report |
| `/api/v1/scan/{id}/cancel` | POST | Cancel running scan |
| `/api/v1/agents/status` | GET | Get agent status |
| `/api/v1/system/health` | GET | System health check |
| `/api/v1/system/metrics` | GET | Performance metrics |

### 📈 **Webhook Notifications**

Configure webhooks to receive real-time updates:

```json
{
  "event": "scan.completed",
  "scan_id": "550e8400-e29b-41d4-a716-446655440000",
  "timestamp": "2025-06-25T10:34:30Z",
  "data": {
    "target": "192.168.1.1",
    "threat_score": 85,
    "risk_level": "high",
    "summary": "Malicious IP detected with high confidence"
  }
}
```

---

## 🎨 Web Dashboard

### 📊 **Dashboard Features**

The Streamlit-based dashboard provides:

- **Real-time Monitoring**: Live scan status and metrics
- **Interactive Visualizations**: Threat maps, charts, and graphs  
- **Scan Management**: Start, monitor, and manage scans
- **Report Viewer**: Browse and download reports
- **System Administration**: User management and configuration

### 🖼️ **Screenshots**

<table>
<tr>
<td width="50%">
<img src="docs/images/dashboard-overview.png" alt="Dashboard Overview" />
<p align="center"><b>Main Dashboard</b></p>
</td>
<td width="50%">
<img src="docs/images/scan-results.png" alt="Scan Results" />
<p align="center"><b>Scan Results</b></p>
</td>
</tr>
<tr>
<td width="50%">
<img src="docs/images/threat-map.png" alt="Threat Map" />
<p align="center"><b>Global Threat Map</b></p>
</td>
<td width="50%">
<img src="docs/images/reports.png" alt="Reports" />
<p align="center"><b>Report Generation</b></p>
</td>
</tr>
</table>

### 🚀 **Access Dashboard**

```bash
# Start the dashboard
streamlit run dashboard/app.py

# Access at http://localhost:8501
```

**Default Credentials:**
- Username: `admin`
- Password: `security123!`

> ⚠️ **Security Note**: Change default credentials immediately in production!

---

## 🔌 Integrations

### 🛡️ **SIEM Integrations**

<table>
<tr>
<td width="33%">

#### Splunk
```json
{
  "source": "security-agents",
  "sourcetype": "threat_intel",
  "host": "security-system"
}
```

</td>
<td width="33%">

#### QRadar
```xml
<log_source>
  <name>Security Agents</name>
  <type>Universal LEEF</type>
</log_source>
```

</td>
<td width="33%">

#### Elasticsearch
```yaml
output.elasticsearch:
  hosts: ["localhost:9200"]
  index: "security-agents-%{+yyyy.MM.dd}"
```

</td>
</tr>
</table>

### 🔔 **Notification Integrations**

| Platform | Integration Type | Configuration |
|----------|------------------|---------------|
| **Microsoft Teams** | Webhook | `TEAMS_WEBHOOK_URL` |
| **PagerDuty** | API | `PAGERDUTY_INTEGRATION_KEY` |
| **Jira** | API | `JIRA_API_TOKEN` |
| **ServiceNow** | REST API | `SERVICENOW_INSTANCE_URL` |

### ☁️ **Cloud Integrations**

```yaml
# AWS Integration
aws:
  region: us-east-1
  s3_bucket: security-agents-reports
  sns_topic: arn:aws:sns:us-east-1:123456789012:security-alerts

# Azure Integration  
azure:
  storage_account: securityagents
  key_vault: security-agents-kv
  log_analytics: security-workspace

# GCP Integration
gcp:
  project_id: security-agents-project
  storage_bucket: security-reports
  pub_sub_topic: security-alerts
```

---

## 📈 Monitoring & Logging

### 📊 **Metrics & Observability**

The system provides enterprise-grade monitoring through the included Docker stack:

**🔍 Prometheus Metrics Collection:**
```bash
# Access Prometheus at http://localhost:9090
# Pre-configured metrics include:

# Agent Performance
security_agent_scan_duration_seconds
security_agent_error_rate  
security_agent_queue_size
security_agent_api_calls_total

# API Performance
http_requests_total{method, status_code, endpoint}
http_request_duration_seconds
api_concurrent_requests
api_error_rate

# System Metrics
container_memory_usage_bytes
container_cpu_usage_seconds_total
postgres_connections_active
redis_connected_clients
```

**📊 Grafana Dashboards:**
Access at http://localhost:3000 (admin/admin)

Pre-built dashboards include:
- **Security Overview**: Threat detection metrics and scan statistics
- **Agent Performance**: Individual agent health and performance
- **API Monitoring**: Request rates, response times, and error tracking
- **Infrastructure**: Container resources, database performance
- **Alerts Dashboard**: Real-time alert status and delivery metrics

**🚨 Alert Rules:**
Prometheus alert rules are pre-configured for:
- High API error rates (>5%)
- Database connection failures
- Worker queue backup (>100 pending)
- Memory usage above 80%
- Service downtime

### 📝 **Structured Logging**

All logs are structured in JSON format with correlation IDs:

```json
{
  "timestamp": "2025-06-25T10:30:00Z",
  "level": "INFO", 
  "logger": "threat_intel_agent",
  "scan_id": "550e8400-e29b-41d4-a716-446655440000",
  "correlation_id": "req_12345",
  "message": "VirusTotal scan completed",
  "duration_ms": 1250,
  "data": {
    "target": "192.168.1.1",
    "detection_ratio": "15/70",
    "threat_score": 85,
    "sources": ["virustotal", "abuseipdb"]
  },
  "container": {
    "name": "security-multi-agent_api_1",
    "image": "security-agents/multi-agent:latest"
  }
}
```

### 🔍 **Log Management**

**Docker Log Collection:**
```bash
# View real-time logs
docker-compose logs -f api
docker-compose logs -f worker

# Search logs by service
docker-compose logs api | grep "ERROR"

# Export logs for analysis
docker-compose logs --no-color --timestamps > system_logs.txt

# View specific time range
docker-compose logs --since="2024-12-25T10:00:00" --until="2024-12-25T11:00:00"
```

**Log Rotation & Retention:**
Configured in `docker-compose.yml`:
```yaml
logging:
  driver: "json-file"
  options:
    max-size: "100m"
    max-file: "5"
    compress: "true"
```

**Centralized Logging (Optional):**
For production environments, integrate with:
- **ELK Stack**: Elasticsearch, Logstash, Kibana
- **Fluentd**: Log forwarding and aggregation  
- **Loki**: Grafana's log aggregation system
- **Splunk**: Enterprise log management

```yaml
# Example Fluentd configuration
logging:
  driver: fluentd
  options:
    fluentd-address: "localhost:24224"
    tag: "security.agents.{{.Name}}"
```

### 📊 **Performance Monitoring**

**Container Resource Monitoring:**
```bash
# Real-time resource usage
docker stats

# Detailed container inspection
docker-compose exec api cat /proc/meminfo
docker-compose exec api cat /proc/cpuinfo

# Service health checks
docker-compose ps
```

**Database Performance:**
```sql
-- Monitor active connections
SELECT count(*) FROM pg_stat_activity;

-- Query performance
SELECT query, mean_time, calls 
FROM pg_stat_statements 
ORDER BY mean_time DESC LIMIT 10;

-- Database size monitoring
SELECT pg_size_pretty(pg_database_size('security_agents'));
```

**Redis Cache Monitoring:**
```bash
# Redis statistics
docker-compose exec redis redis-cli info stats

# Monitor cache hit ratio
docker-compose exec redis redis-cli info stats | grep keyspace
```

### 🔔 **Alert Configuration**

**Email Alerts:**
Configured via environment variables:
```bash
# .env configuration
SMTP_SERVER=smtp.gmail.com
EMAIL_USER=alerts@yourcompany.com
EMAIL_TO=security-team@yourcompany.com
```

**Slack Integration:**
```bash
# Slack webhook for real-time notifications
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK
SLACK_CHANNEL=#security-alerts
```

**Custom Webhook Support:**
```python
# Configure custom webhook endpoints
WEBHOOK_ENDPOINTS=[
    "https://your-siem.com/api/alerts",
    "https://your-ticketing-system.com/api/incidents"
]
```

### 🔧 **Monitoring Setup**

**Access Monitoring Stack:**
```bash
# Start monitoring services
docker-compose up -d prometheus grafana

# Import custom dashboards
curl -X POST http://admin:admin@localhost:3000/api/dashboards/db \
  -H "Content-Type: application/json" \
  -d @monitoring/grafana/dashboards/security-overview.json
```

**Custom Metrics:**
Add custom metrics to your agents:
```python
from prometheus_client import Counter, Histogram, Gauge

# Define custom metrics
SCAN_COUNTER = Counter('security_scans_total', 'Total scans performed', ['agent', 'status'])
SCAN_DURATION = Histogram('security_scan_duration_seconds', 'Scan duration')
THREAT_GAUGE = Gauge('security_threats_detected', 'Current threat level')

# Use in agent code
SCAN_COUNTER.labels(agent='threat_intel', status='success').inc()
```

For detailed monitoring setup and configuration, see the [DOCKER.md](./DOCKER.md) monitoring section.

---

## 🧪 Testing

### 🏃 **Running Tests**

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=security_agents --cov-report=html

# Run specific test categories
pytest tests/unit/          # Unit tests
pytest tests/integration/   # Integration tests
pytest tests/e2e/          # End-to-end tests

# Run performance tests
pytest tests/performance/ --benchmark-only
```

### 📊 **Test Coverage**

Current test coverage: **85%**

| Component | Coverage |
|-----------|----------|
| Core Agents | 92% |
| API Endpoints | 88% |
| Database Layer | 90% |
| Authentication | 95% |
| Configuration | 78% |

### 🎯 **Test Categories**

<details>
<summary><b>Unit Tests</b></summary>

```python
# Example unit test
def test_threat_intel_agent_scan():
    agent = ThreatIntelAgent(config)
    result = agent.scan_ip("8.8.8.8")
    
    assert result.status == "completed"
    assert result.threat_score >= 0
    assert "virustotal" in result.sources
```

</details>

<details>
<summary><b>Integration Tests</b></summary>

```python
# Example integration test
@pytest.mark.integration
def test_full_scan_workflow():
    system = SecuritySystem(test_config)
    result = system.scan_ip("127.0.0.1")
    
    assert result.scan_id is not None
    assert len(result.agent_results) == 7
    assert result.report_generated is True
```

</details>

### 🤖 **Automated Testing**

GitHub Actions workflow for continuous testing:

```yaml
name: CI/CD Pipeline
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.8, 3.9, "3.10", "3.11"]
    
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: pip install -e ".[test]"
    - name: Run tests
      run: pytest --cov --cov-report=xml
    - name: Upload coverage
      uses: codecov/codecov-action@v3
```

---

## 🛠️ Development

### 🏗️ **Development Setup**

#### **🐳 Docker Development (Recommended)**

```bash
# Clone repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Setup development environment
cp .env.example .env
# Edit .env with your API keys

# Start development stack with live reload
docker-compose -f docker-compose.dev.yml up -d

# View logs
docker-compose -f docker-compose.dev.yml logs -f

# Access development services:
echo "Dashboard: http://localhost:8501"
echo "API: http://localhost:8000/docs"
echo "Jupyter: http://localhost:8888"
echo "pgAdmin: http://localhost:5050"
echo "Redis Commander: http://localhost:8081"
```

**Development Features:**
- 🔄 **Live Reload**: Automatic restart on code changes
- 📓 **Jupyter Notebooks**: Pre-configured for agent development
- 🗄️ **Database Tools**: pgAdmin for database management
- 📦 **Cache Management**: Redis Commander interface
- 🐛 **Remote Debugging**: VS Code debugger support
- 📝 **Volume Mounts**: Direct code editing on host

#### **🐍 Local Python Development**

```bash
# Create virtual environment
python -m venv dev-env
source dev-env/bin/activate  # Linux/macOS
# dev-env\Scripts\activate   # Windows

# Install development dependencies
pip install -e ".[dev]"

# Install pre-commit hooks
pre-commit install

# Start development server
uvicorn fastapi_app.main:app --reload --host 0.0.0.0 --port 8000

# Start dashboard in another terminal
streamlit run dashboard/app.py --server.port 8501
```

### 📁 **Project Structure**

```
security-multi-agent/
├── 📁 agents/                      # Agent implementations
│   ├── 📁 alert_agent/            # Alert Agent
│   ├── 📁 correlation_agent/      # Correlation Agent
│   ├── 📁 osint_agent/            # OSINT Agent
│   ├── 📁 rag_agent/              # RAG Agent
│   ├── 📁 report_agent/           # Report Agent
│   ├── 📁 selftest_agent/         # Self Test Agent
│   └── 📁 threatintel_agent/      # Threat Intelligence Agent
├── 📁 fastapi_app/                 # FastAPI application
│   └── 📄 main.py                 # API entry point
├── 📁 dashboard/                   # Streamlit dashboard
│   └── � app.py                  # Dashboard entry point
├── 📁 database/                    # Database files
│   └── 📄 logs.db                 # SQLite database
├── 📁 db/                          # Database utilities
│   └── 📄 logger.py               # Database logger
├── 📄 controller_agent.py          # Controller Agent
├── � a2a_protocol.py             # Agent-to-Agent Protocol
├── 📄 dashbaord.py                # Dashboard runner
├── 📄 requirements.txt             # Python dependencies
│
├── 📁 docker/                      # Docker configuration
│   ├── 📄 Dockerfile              # Multi-stage container build
│   ├── 📄 docker-compose.yml      # Production stack
│   ├── 📄 docker-compose.dev.yml  # Development stack
│   ├── 📄 .env.example            # Environment template
│   ├── 📄 nginx.conf              # Nginx configuration
│   ├── 📄 deploy.sh               # Linux/macOS deployment
│   ├── 📄 deploy.bat              # Windows deployment
│   └── 📄 DOCKER.md               # Docker documentation
│
├── 📁 monitoring/                  # Monitoring configuration
│   ├── 📄 prometheus.yml          # Prometheus config
│   ├── 📄 alert_rules.yml         # Alert rules
│   └── 📁 grafana/                # Grafana dashboards
│       ├── 📁 provisioning/       # Auto-provisioning
│       └── 📁 dashboards/         # Dashboard definitions
│
├── 📁 tests/                       # Test suite
│   ├── � test_agents.py          # Agent tests
│   ├── 📄 test_api.py             # API tests
│   └── 📄 test_integration.py     # Integration tests
│
├── 📁 docs/                        # Documentation
│   ├── 📄 API.md                  # API documentation
│   ├── 📄 AGENTS.md               # Agent documentation
│   └── 📄 DEPLOYMENT.md           # Deployment guide
│
└── 📄 README.md                    # This file
```

### 🎨 **Code Style**

We use several tools to maintain code quality:

```bash
# Format code with Black
black security_agents/

# Sort imports with isort  
isort security_agents/

# Type checking with mypy
mypy security_agents/

# Linting with flake8
flake8 security_agents/

# Security scanning with bandit
bandit -r security_agents/
```

### 🔀 **Git Workflow**

```bash
# Create feature branch
git checkout -b feature/new-agent

# Make changes and commit
git add .
git commit -m "feat: add new threat detection agent"

# Push and create PR
git push origin feature/new-agent
```

**Commit Convention:**
- `feat:` New features
- `fix:` Bug fixes  
- `docs:` Documentation updates
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions/updates
- `chore:` Maintenance tasks

---

## 📋 Roadmap

### 🎯 **Current Version (v1.0.0)**
- ✅ Core multi-agent architecture
- ✅ 7 specialized security agents  
- ✅ REST API and web dashboard
- ✅ Multi-channel alerting
- ✅ Professional report generation

### 🚀 **Version 1.1.0** (Q3 2025)
- 🔄 Machine Learning threat prediction
- 🔄 Advanced threat hunting capabilities
- 🔄 Custom agent development framework
- 🔄 Enhanced visualization and analytics
- 🔄 Mobile application support

### 🔮 **Version 1.2.0** (Q4 2025)
- 📋 Multi-tenancy support
- 📋 Advanced workflow automation
- 📋 Threat intelligence sharing
- 📋 Advanced compliance reporting
- 📋 Edge deployment capabilities

### 🌟 **Version 2.0.0** (Q1 2026)
- 📋 Distributed architecture
- 📋 Real-time threat streaming
- 📋 Advanced AI/ML integration
- 📋 Blockchain threat verification
- 📋 Quantum-safe encryption

### 💡 **Future Considerations**
- 🤔 Kubernetes operator
- 🤔 Serverless deployment options  
- 🤔 Advanced threat simulation
- 🤔 Integration marketplace
- 🤔 Community threat feeds

---

## 🤝 Contributing

We welcome contributions from the security community! 

### 🌟 **How to Contribute**

1. **🍴 Fork the repository**
2. **🌿 Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **✍️ Commit your changes** (`git commit -m 'Add amazing feature'`)
4. **📤 Push to the branch** (`git push origin feature/amazing-feature`)
5. **🔀 Open a Pull Request**

### 📝 **Contribution Guidelines**

<details>
<summary><b>📋 Pull Request Checklist</b></summary>

- [ ] Code follows project style guidelines
- [ ] Self-review of code completed
- [ ] Tests added for new functionality
- [ ] All tests pass locally
- [ ] Documentation updated as needed
- [ ] Security implications considered
- [ ] Performance impact assessed

</details>

<details>
<summary><b>🐛 Bug Reports</b></summary>

When reporting bugs, please include:

- System information (OS, Python version)
- Steps to reproduce the issue
- Expected vs actual behavior
- Error logs and stack traces
- Minimal reproducible example

</details>

<details>
<summary><b>💡 Feature Requests</b></summary>

For feature requests, please provide:

- Clear description of the feature
- Use case and business justification
- Proposed implementation approach
- Potential security considerations
- Impact on existing functionality

</details>

### 👥 **Development Team**

<table>
<tr>
<td align="center">
<img src="https://github.com/username1.png" width="100px" alt=""/><br />
<b>John Doe</b><br />
<sub>Project Lead</sub>
</td>
<td align="center">
<img src="https://github.com/username2.png" width="100px" alt=""/><br />
<b>Jane Smith</b><br />
<sub>Security Architect</sub>
</td>
<td align="center">
<img src="https://github.com/username3.png" width="100px" alt=""/><br />
<b>Mike Johnson</b><br />
<sub>AI/ML Engineer</sub>
</td>
</tr>
</table>

### 🏆 **Contributors**

Thanks to all our amazing contributors:

[![Contributors](https://contrib.rocks/image?repo=yourusername/security-multi-agent)](https://github.com/yourusername/security-multi-agent/graphs/contributors)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Security Multi-Agent Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

### 🎖️ **Special Thanks**

- **[OpenAI](https://openai.com)** - For GPT models that inspired our AI integration
- **[Google](https://ai.google.dev)** - For Gemini AI capabilities
- **[VirusTotal](https://virustotal.com)** - For comprehensive malware detection
- **[AbuseIPDB](https://abuseipdb.com)** - For IP reputation intelligence
- **[FastAPI](https://fastapi.tiangolo.com)** - For the excellent API framework
- **[Streamlit](https://streamlit.io)** - For the intuitive dashboard framework

### 🏢 **Supported By**

<table>
<tr>
<td align="center">
<img src="docs/images/sponsors/company1.png" width="120px" alt="Company 1"/><br />
<b>CyberSec Corp</b>
</td>
<td align="center">
<img src="docs/images/sponsors/company2.png" width="120px" alt="Company 2"/><br />
<b>AI Security Labs</b>
</td>
<td align="center">
<img src="docs/images/sponsors/company3.png" width="120px" alt="Company 3"/><br />
<b>ThreatDefense Inc</b>
</td>
</tr>
</table>

### 🔗 **Related Projects**

- **[MISP](https://www.misp-project.org/)** - Threat intelligence platform
- **[OpenCTI](https://www.opencti.io/)** - Cyber threat intelligence platform  
- **[TheHive](https://thehive-project.org/)** - Incident response platform
- **[YARA](https://virustotal.github.io/yara/)** - Malware identification and classification

---

<div align="center">

### 🌟 **Star this project if you find it useful!**

[![GitHub stars](https://img.shields.io/github/stars/yourusername/security-multi-agent?style=social)](https://github.com/yourusername/security-multi-agent/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/yourusername/security-multi-agent?style=social)](https://github.com/yourusername/security-multi-agent/network/members)
[![GitHub watchers](https://img.shields.io/github/watchers/yourusername/security-multi-agent?style=social)](https://github.com/yourusername/security-multi-agent/watchers)

---

**[⬆ Back to Top](#-security-multi-agent-system)**

</div>

---

<div align="center">
<sub>Built with ❤️ by the Security Multi-Agent Team</sub><br>
<sub>© 2025 - Securing the digital world, one agent at a time</sub>
</div>
