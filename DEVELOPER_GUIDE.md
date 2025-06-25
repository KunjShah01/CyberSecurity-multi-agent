# 🚀 Security Multi-Agent System: Developer Guide

Welcome to the Security Multi-Agent System Developer Guide! This comprehensive documentation is designed to take you from zero to hero—whether you're a beginner or an experienced developer. You'll learn how to set up, understand, extend, and contribute to the project with best practices and real-world examples.

---

## 👶 Quickstart for Newbies

If you're new to Python, Docker, or open source, don't worry! Follow these steps to get started quickly:

1. **Install Python**: [Download Python 3.8+](https://www.python.org/downloads/)
2. **Install Git**: [Download Git](https://git-scm.com/downloads)
3. **Install Docker Desktop**: [Get Docker](https://www.docker.com/products/docker-desktop/)
4. **Clone the Project**:
   ```bash
   git clone https://github.com/yourusername/security-multi-agent.git
   cd security-multi-agent
   ```
5. **Copy Example Environment File**:
   ```bash
   cp .env.example .env
   # Edit .env with your API keys (see below)
   ```
6. **Start Everything with Docker**:
   ```bash
   docker-compose up -d
   ```
7. **Open the Dashboard**: Go to [http://localhost:8501](http://localhost:8501) in your browser.

**Need help?** See the [FAQ](#faq) and [Troubleshooting](#troubleshooting) sections below.

---

## 📚 Table of Contents

- [🚀 Security Multi-Agent System: Developer Guide](#-security-multi-agent-system-developer-guide)
  - [👶 Quickstart for Newbies](#-quickstart-for-newbies)
  - [📚 Table of Contents](#-table-of-contents)
  - [Learning Path: From Newbie to Pro](#learning-path-from-newbie-to-pro)
  - [1. Introduction](#1-introduction)
  - [2. Project Structure](#2-project-structure)
  - [3. Getting Started](#3-getting-started)
    - [Onboarding Tips for Beginners](#onboarding-tips-for-beginners)
    - [Prerequisites](#prerequisites)
    - [Setup (Docker Recommended)](#setup-docker-recommended)
    - [Local Python Setup](#local-python-setup)
  - [4. Configuration](#4-configuration)
  - [5. Core Concepts](#5-core-concepts)
  - [6. Agent Architecture](#6-agent-architecture)
  - [7. Developing New Agents](#7-developing-new-agents)
  - [8. API Development](#8-api-development)
  - [9. Web Dashboard](#9-web-dashboard)
  - [10. Testing \& Quality](#10-testing--quality)
  - [11. Debugging \& Troubleshooting](#11-debugging--troubleshooting)
  - [12. Security Best Practices](#12-security-best-practices)
  - [13. Deployment](#13-deployment)
  - [14. Contributing](#14-contributing)
  - [15. Resources \& References](#15-resources--references)
  - [16. Troubleshooting](#16-troubleshooting)
  - [17. FAQ](#17-faq)

---

## Learning Path: From Newbie to Pro

**Absolute Beginner:**
- Read the [Introduction](#1-introduction) and [Project Structure](#2-project-structure)
- Follow [Getting Started](#3-getting-started) step-by-step
- Use the [Glossary](#glossary) at the end for unfamiliar terms
- Try running your first scan from the dashboard or CLI

**Intermediate Developer:**
- Explore [Agent Architecture](#6-agent-architecture) and [API Development](#8-api-development)
- Add a simple new agent or endpoint
- Write and run tests ([Testing & Quality](#10-testing--quality))
- Learn about [Debugging](#11-debugging--troubleshooting)

**Advanced/Experienced Developer:**
- Dive into advanced agent orchestration and A2A protocol
- Optimize performance and security ([Security Best Practices](#12-security-best-practices))
- Contribute new features, refactor code, or improve CI/CD
- Review [Deployment](#13-deployment) for scaling and production

---

## 1. Introduction

The Security Multi-Agent System is an AI-powered cybersecurity platform that orchestrates multiple specialized agents for threat intelligence, OSINT, AI analysis, and automated incident response. It is designed for extensibility, security, and ease of use.

**What you can learn here:**
- How to set up and run the system
- How to build and test new agents
- How to extend the API and dashboard
- How to follow best security and coding practices

---

## 2. Project Structure

```
security-multi-agent/
├── agents/                 # All agent implementations
│   ├── alert_agent/
│   ├── correlation_agent/
│   ├── osint_agent/
│   ├── rag_agent/
│   ├── report_agent/
│   ├── selftest_agent/
│   └── threatintel_agent/
├── fastapi_app/            # FastAPI backend
├── dashboard/              # Streamlit frontend
├── database/               # Database files
├── db/                     # Database utilities
├── controller_agent.py     # Main controller
├── a2a_protocol.py         # Agent communication
├── requirements.txt        # Python dependencies
├── docker-compose.yml      # Production stack
├── docker-compose.dev.yml  # Development stack
├── README.md               # Project overview
└── DEVELOPER_GUIDE.md      # This guide
```

---

## 3. Getting Started

### Onboarding Tips for Beginners
- If you are new to Python, start with [Python Official Tutorial](https://docs.python.org/3/tutorial/)
- If you are new to Docker, see [Docker Getting Started](https://docs.docker.com/get-started/)
- If you are new to Git, try [GitHub Learning Lab](https://lab.github.com/)
- Don’t hesitate to Google errors or ask for help!

### Prerequisites
- Python 3.8+
- Docker & Docker Compose (recommended)
- Git
- Basic command line knowledge

### Setup (Docker Recommended)
```bash
# Clone the repository
git clone https://github.com/yourusername/security-multi-agent.git
cd security-multi-agent

# Copy and edit environment variables
cp .env.example .env
# Edit .env with your API keys and settings

# Start the stack
docker-compose up -d
```

### Local Python Setup
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
# venv\Scripts\activate  # Windows
pip install -r requirements.txt
python controller_agent.py
```

> **Beginner Tip:** If you get stuck, Google the error message or ask for help on [Stack Overflow](https://stackoverflow.com/), or open an issue on GitHub.

---

## 4. Configuration

> **Beginner Tip:** Never share your `.env` file or API keys publicly!

- All configuration is managed via `.env` and `config.yaml`.
- Sensitive keys (API, DB, JWT) must be kept secret.
- Example `.env` and `config.yaml` files are provided.

**.env Example:**
```
VT_API_KEY=your_virustotal_api_key
ABUSEIPDB_API_KEY=your_abuseipdb_api_key
IPINFO_TOKEN=your_ipinfo_token
GEMINI_API_KEY=your_google_gemini_api_key
SECRET_KEY=your_secret_key_here
```

---

## 5. Core Concepts

> **Glossary:**
> - **Agent**: A mini-program that does a specific security job.
> - **Controller Agent**: The boss that tells other agents what to do.
> - **A2A Protocol**: The way agents talk to each other.
> - **API**: Lets other programs talk to this system.
> - **Dashboard**: The web app you use to control everything.

- **Agent**: A modular, independent component that performs a specific security function.
- **Controller Agent**: Orchestrates the workflow and communication between agents.
- **A2A Protocol**: Secure, structured messaging between agents.
- **API**: RESTful endpoints for automation and integration.
- **Dashboard**: Web UI for interactive use and visualization.

---

## 6. Agent Architecture

> **Pro Tip:** Use Python classes for agents to keep your code organized and testable.

**Beginner Example:**
```python
class HelloWorldAgent:
    def run(self, input_data):
        return {"message": "Hello, world!"}
```

**Advanced Tip:**
- Use Python’s `async` and `await` for high-performance agents
- Use dependency injection for testability

Each agent is a Python module/class with a clear interface:
- `run()` or `analyze()` method as entry point
- Receives structured input (dict or dataclass)
- Returns structured output (dict or dataclass)
- Can be run independently for testing

**Example Agent Skeleton:**
```python
class ExampleAgent:
    def __init__(self, config):
        self.config = config
    def run(self, input_data):
        # ...logic...
        return {"result": "ok"}
```

---

## 7. Developing New Agents

> **Beginner Tip:** Start by copying an existing agent folder and modifying it.
> **Advanced:** Use dependency injection and type hints for more robust code.

**Beginner Steps:**
- Copy an existing agent folder and rename it
- Change the logic in the `run()` method
- Test it by calling it directly in a Python shell

**Advanced Steps:**
- Add configuration options and error handling
- Write unit and integration tests
- Document your agent with docstrings and comments

1. **Create a new folder** in `agents/` (e.g., `agents/my_agent/`).
2. **Implement your agent** as a Python class/module.
3. **Define a clear interface** (`run()` or `analyze()` method).
4. **Add configuration options** if needed.
5. **Write tests** in `tests/`.
6. **Register your agent** in `controller_agent.py`.
7. **Document your agent** in the code and README.

**Agent Template:**
```python
class MyAgent:
    def __init__(self, config):
        self.config = config
    def run(self, input_data):
        # Your logic here
        return {"output": "result"}
```

---

## 8. API Development

> **Pro Tip:** Use [Pydantic](https://docs.pydantic.dev/) models for data validation.

**Beginner Tip:**
- Use [Swagger UI](http://localhost:8000/docs) to try API endpoints without writing code

**Advanced Tip:**
- Use FastAPI dependencies for authentication, rate limiting, etc.
- Add OpenAPI documentation for new endpoints

- The backend uses FastAPI (`fastapi_app/`).
- Endpoints are defined in `main.py`.
- Use Pydantic models for request/response validation.
- Add new endpoints for new agent features as needed.

**Example Endpoint:**
```python
from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class ScanRequest(BaseModel):
    query: str
    scan_type: str

@router.post("/scan")
def scan(request: ScanRequest):
    # Call controller agent
    return {"result": "scan started"}
```

---

## 9. Web Dashboard

> **Beginner Tip:** Streamlit lets you build UIs with just a few lines of Python.

**Advanced Tip:**
- Use session state for multi-step workflows
- Integrate real-time updates with WebSockets

- Built with Streamlit (`dashboard/app.py`).
- Use widgets for user input and display results.
- Integrate new agent features by adding new UI components.

**Example Streamlit Widget:**
```python
import streamlit as st
st.title("Security Multi-Agent Dashboard")
query = st.text_input("Enter IP, domain, or email:")
if st.button("Scan"):
    # Call backend API
    st.write("Scan started!")
```

---

## 10. Testing & Quality

> **Beginner Tip:** Run `pytest` after every change to catch bugs early.
> **Advanced:** Set up CI/CD to automate tests on every pull request.

**Beginner Tip:**
- Run `pytest` and look for green (pass) or red (fail)
- Start with simple tests: check if your agent returns the right output

**Advanced Tip:**
- Use fixtures and mocks for complex tests
- Integrate tests with CI/CD (GitHub Actions, etc.)

- Use `pytest` for all tests.
- Place tests in `tests/` directory.
- Aim for high coverage (unit, integration, API tests).
- Use `black`, `isort`, `flake8`, and `bandit` for code quality and security.

**Run Tests:**
```bash
pytest
pytest --cov=agents --cov-report=html
```

---

## 11. Debugging & Troubleshooting

> **Beginner Tip:** Use `print()` to see what's happening in your code.
> **Advanced:** Use Python's `logging` module for more control and log levels.

**Beginner Tip:**
- Use `print()` to see what your code is doing
- Check logs in the terminal or with `docker-compose logs`

**Advanced Tip:**
- Use Python’s `logging` module for structured logs
- Use a debugger (e.g., VS Code, PyCharm) to step through code

- Use `docker-compose logs` or `docker logs` for container output.
- Use `print()` or logging for debugging Python code.
- For API debugging, use tools like Postman or curl.
- Check `.env` and config for misconfigurations.
- Use `pytest -s` for verbose test output.

---

## 12. Security Best Practices

> **Pro Tip:** Use tools like [Bandit](https://bandit.readthedocs.io/) and [Trivy](https://aquasecurity.github.io/trivy/) to scan for vulnerabilities.

**Beginner Tip:**
- Never post your `.env` file or secrets online
- Always use strong, unique passwords

**Advanced Tip:**
- Use Docker secrets or Vault for production secrets
- Set up automated vulnerability scanning (Trivy, Bandit, etc.)
- Enforce least privilege for all agents and services

- Never commit secrets or API keys to git.
- Use non-root users in Docker containers.
- Keep dependencies up to date.
- Run security scans (`bandit`, `trivy`, etc.) regularly.
- Use HTTPS and secure headers in production.
- Rotate keys and passwords regularly.

---

## 13. Deployment

> **Beginner Tip:** Always test locally before deploying to production.
> **Advanced:** Use environment-specific configs and secrets managers for production.

**Beginner Tip:**
- Use Docker Compose for easy local deployment
- Always test in development before deploying to production

**Advanced Tip:**
- Use environment-specific configs for dev, staging, and prod
- Set up monitoring and alerting for production deployments

- **Production**: Use `docker-compose.yml` with secure environment variables.
- **Development**: Use `docker-compose.dev.yml` for live reload and debugging.
- **Cloud**: Can be deployed to AWS, GCP, Azure, or any Docker-compatible host.
- **Backup**: Regularly backup database and configuration files.

---

## 14. Contributing

> **Beginner Tip:** Read the [GitHub Flow Guide](https://guides.github.com/introduction/flow/) if you're new to pull requests.
> **Advanced:** Write unit tests for every new feature and document your code.

**For Beginners:**
- Read the [GitHub Flow Guide](https://guides.github.com/introduction/flow/)
- Ask questions in issues or discussions if you’re stuck
- Start with documentation or small bug fixes

**For Experienced Developers:**
- Review open issues and propose architectural improvements
- Refactor code for performance, security, or maintainability
- Mentor new contributors and review pull requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make changes and add tests
4. Run tests and ensure all pass
5. Commit and push (`git commit -m 'Add my feature'`)
6. Open a Pull Request

**Contribution Tips:**
- Write clear, concise code and comments
- Add or update documentation
- Follow PEP 8 and project style
- Be security conscious

---

## 15. Resources & References

**Learning Resources for All Levels:**
- [Python for Beginners](https://www.learnpython.org/)
- [Docker for Beginners](https://docker-curriculum.com/)
- [FastAPI Crash Course](https://www.youtube.com/watch?v=0sOvCWFmrtA)
- [Streamlit Tutorials](https://docs.streamlit.io/)
- [GitHub Guides](https://guides.github.com/)
- [OWASP Top 10 Security Risks](https://owasp.org/www-project-top-ten/)

---

## 16. Troubleshooting

**Common Issues:**
- **Docker won't start**: Make sure Docker Desktop is running.
- **Can't install Python packages**: Check your Python version and virtual environment.
- **API keys not working**: Double-check your `.env` file and restart the app.
- **Database errors**: Make sure the `database/logs.db` file exists and is writable.

**Still stuck?**
- Search the [project issues](https://github.com/yourusername/security-multi-agent/issues)
- Ask for help on [Stack Overflow](https://stackoverflow.com/)
- Reach out to the community or maintainers

---

## 17. FAQ

**Q: I'm new to Python. Where can I learn more?**
- [Python for Beginners](https://www.python.org/about/gettingstarted/)
- [Real Python Tutorials](https://realpython.com/)

**Q: How do I get API keys for the agents?**
- Sign up for each service (e.g., VirusTotal, AbuseIPDB) and copy your API key into `.env`.

**Q: Can I run this on Windows/Mac/Linux?**
- Yes! Docker makes it platform-independent.

**Q: How do I contribute?**
- See the [Contributing](#14-contributing) section above.

**Q: Where can I ask more questions?**
- Open an issue on GitHub or join the project chat if available.

---

**Happy hacking! Build, learn, and secure the world with the Security Multi-Agent System.**
