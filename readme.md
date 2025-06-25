# 🛡️ Security Multi-Agent System

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![FastAPI](https://img.shields.io/badge/FastAPI-005571?logo=fastapi)](https://fastapi.tiangolo.com)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?logo=streamlit&logoColor=white)](https://streamlit.io)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/security-agents/multi-agent)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)


> **An AI-powered cybersecurity threat intelligence platform that orchestrates multiple specialized agents to provide comprehensive security analysis, real-time threat detection, and automated incident response.**

---

## 🚀 Quick Start

Get up and running in under 5 minutes:

```bash
# Clone the repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Copy environment template
cp .env.example .env
# Edit .env with your API keys

# Start with Docker
docker-compose up -d

# Or run locally
pip install -r requirements.txt
python controller_agent.py
```

**Access Points:**
- 🖥️ **Dashboard**: http://localhost:8501
- 📚 **API Docs**: http://localhost:8000/docs

---

## ✨ Features

### 🔍 **Threat Intelligence**
- **VirusTotal**: Real-time malware scanning
- **AbuseIPDB**: IP reputation analysis
- **IPInfo**: Geolocation and ISP data
- **Multi-source correlation**: Cross-reference threat data

### 🕵️ **OSINT Capabilities**
- **HaveIBeenPwned**: Email breach detection
- **Hunter.io**: Domain intelligence
- **Automated collection**: OSINT data gathering
- **Dark web monitoring**: Threat actor identification

### 🤖 **AI-Powered Analysis**
- **Google Gemini**: Advanced LLM analysis
- **RAG**: Context-aware insights
- **Pattern recognition**: Threat correlation
- **Automated reporting**: Professional security reports

### 🚨 **Multi-Channel Alerts**
- **Email**: SMTP notifications
- **Slack**: Real-time team alerts
- **Discord**: Community notifications
- **Webhooks**: Custom integrations

---

## 🏗️ Architecture

The system uses a **multi-agent architecture** with specialized agents:

- **🎮 Controller Agent**: Orchestrates the workflow
- **🔍 Threat Intel Agent**: Collects threat intelligence
- **🕵️ OSINT Agent**: Performs open source intelligence
- **🧮 Correlation Agent**: AI-powered data correlation
- **📚 RAG Agent**: Real-time web intelligence
- **📄 Report Agent**: Automated report generation
- **🧪 Self-Test Agent**: Quality assurance
- **🚨 Alert Agent**: Multi-channel notifications

**Agent Workflow:**
1. Input processing and validation
2. Threat intelligence collection
3. OSINT analysis
4. AI correlation and analysis
5. Report generation
6. Quality assurance
7. Multi-channel alerting
8. Audit logging

---

## 📦 Installation

### Prerequisites
- Python 3.8+
- 4GB RAM (8GB+ recommended)
- Internet access for API integrations

### Method 1: Docker (Recommended)

```bash
# Clone and setup
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Configure environment
cp .env.example .env
# Edit .env with your API keys

# Deploy
docker-compose up -d

# Verify
docker-compose ps
```

### Method 2: Local Installation

```bash
# Clone repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Run system
python controller_agent.py
```

---

## ⚙️ Configuration

Create `.env` file with your API keys:

```bash
# Required API Keys
VT_API_KEY=your_virustotal_api_key
ABUSEIPDB_API_KEY=your_abuseipdb_api_key
IPINFO_TOKEN=your_ipinfo_token
GEMINI_API_KEY=your_google_gemini_api_key

# Optional API Keys
SERPAPI_API_KEY=your_serpapi_key
HUNTER_API_KEY=your_hunter_io_key

# Email Alerts
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
EMAIL_USER=your_email@gmail.com
EMAIL_PASSWORD=your_app_password
RECIPIENT_EMAIL=alerts@yourcompany.com

# Slack Integration
SLACK_WEBHOOK_URL=your_slack_webhook_url

# Discord Integration
DISCORD_WEBHOOK_URL=your_discord_webhook_url

# Application Settings
DEBUG=false
LOG_LEVEL=INFO
SECRET_KEY=your_secret_key_here
```

### API Requirements

| Service | Required | Purpose | Free Tier |
|---------|----------|---------|-----------|
| VirusTotal | ✅ | Malware detection | 1,000/day |
| AbuseIPDB | ✅ | IP reputation | 1,000/day |
| IPInfo | ✅ | Geolocation | 50,000/month |
| Google Gemini | ✅ | AI analysis | Free tier |
| SerpAPI | ⚠️ | Web search | 100/month |
| HaveIBeenPwned | ⚠️ | Breach data | Rate limited |
| Hunter.io | ⚠️ | Domain intel | 25/month |

---

## 🔧 Usage

### Web Dashboard

1. Open http://localhost:8501
2. Enter target (IP, domain, email)
3. Select scan type
4. Configure alerts
5. Run analysis
6. Download reports

### API Usage

```bash
# Health check
curl http://localhost:8000/health

# Start scan
curl -X POST "http://localhost:8000/scan" \
     -H "Content-Type: application/json" \
     -d '{"query": "8.8.8.8", "scan_type": "quick"}'

# Get results
curl http://localhost:8000/results/{scan_id}
```

### Command Line

```bash
# Quick scan
python controller_agent.py --query "8.8.8.8" --type quick

# Deep analysis
python controller_agent.py --query "suspicious-domain.com" --type deep

# OSINT only
python controller_agent.py --query "target@email.com" --type osint
```

---

## 🤖 Agents

### Threat Intelligence Agent
- **Location**: `agents/threatintel_agent/`
- **Purpose**: Collect threat data from VirusTotal, AbuseIPDB, IPInfo
- **Tools**: `virustotal.py`, `abuseipdb.py`, `ipinfo.py`

### OSINT Agent
- **Location**: `agents/osint_agent/`
- **Purpose**: Open source intelligence gathering
- **Tools**: `haveibeenpwned.py`, `hunterio.py`

### Correlation Agent
- **Location**: `agents/correlation_agent/`
- **Purpose**: AI-powered threat correlation
- **Features**: Pattern recognition, risk assessment

### RAG Agent
- **Location**: `agents/rag_agent/`
- **Purpose**: Real-time web intelligence
- **Tools**: `serpapi_search.py`

### Report Agent
- **Location**: `agents/report_agent/`
- **Purpose**: Professional report generation
- **Templates**: `report_template.md`

### Alert Agent
- **Location**: `agents/alert_agent/`
- **Purpose**: Multi-channel notifications
- **Channels**: Email, Slack, Discord, Webhooks

### Self-Test Agent
- **Location**: `agents/selftest_agent/`
- **Purpose**: Quality assurance and validation
- **Features**: Data integrity, performance monitoring

---

## 📊 API Reference

### Authentication
```bash
# Login
POST /auth/login
{
  "username": "admin",
  "password": "password"
}

# Use token
Authorization: Bearer {token}
```

### Scan Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/scan` | POST | Start new scan |
| `/scan/{id}` | GET | Get scan results |
| `/scans` | GET | List all scans |
| `/scan/{id}/report` | GET | Download report |
| `/health` | GET | System health |

### Example Scan Response
```json
{
  "scan_id": "550e8400-e29b-41d4-a716-446655440000",
  "status": "completed",
  "target": "192.168.1.1",
  "threat_score": 85,
  "risk_level": "high",
  "results": {
    "threat_intel": {
      "virustotal": {
        "malicious_count": 15,
        "total_engines": 70
      },
      "abuseipdb": {
        "abuse_confidence": 92
      }
    }
  }
}
```

---

## 🧪 Testing

```bash
# Run all tests
pytest

# With coverage
pytest --cov=agents --cov-report=html

# Specific tests
pytest tests/test_agents.py
pytest tests/test_api.py
```

**Test Coverage**: 85%

---

## 🛠️ Development

### Docker Development
```bash
# Start development environment
docker-compose -f docker-compose.dev.yml up -d

# Access tools
echo "Dashboard: http://localhost:8501"
echo "API: http://localhost:8000/docs"
echo "Jupyter: http://localhost:8888"
```

### Local Development
```bash
# Setup
python -m venv dev-env
source dev-env/bin/activate
pip install -r requirements-dev.txt

# Code quality
black .
isort .
flake8 .
mypy .
```

### Project Structure
```
security-multi-agent/
├── agents/                 # Agent implementations
│   ├── alert_agent/
│   ├── correlation_agent/
│   ├── osint_agent/
│   ├── rag_agent/
│   ├── report_agent/
│   ├── selftest_agent/
│   └── threatintel_agent/
├── fastapi_app/           # FastAPI backend
├── dashboard/             # Streamlit frontend
├── database/              # Database files
├── controller_agent.py    # Main controller
├── a2a_protocol.py       # Agent communication
└── requirements.txt      # Dependencies
```

---

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/new-feature`)
3. Commit changes (`git commit -m 'Add new feature'`)
4. Push to branch (`git push origin feature/new-feature`)
5. Open Pull Request

### Guidelines
- Follow PEP 8 style
- Add tests for new features
- Update documentation
- Security-first approach

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **[VirusTotal](https://virustotal.com)** - Malware detection
- **[AbuseIPDB](https://abuseipdb.com)** - IP reputation
- **[Google Gemini](https://ai.google.dev)** - AI capabilities
- **[FastAPI](https://fastapi.tiangolo.com)** - API framework
- **[Streamlit](https://streamlit.io)** - Dashboard framework

---

<div align="center">

**Built with ❤️ for the cybersecurity community**

[⭐ Star this project](https://github.com/yourusername/security-multi-agent) • [🐛 Report Bug](https://github.com/yourusername/security-multi-agent/issues) • [💡 Request Feature](https://github.com/yourusername/security-multi-agent/issues)

</div>
