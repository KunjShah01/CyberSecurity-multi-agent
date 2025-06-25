# 🛡️ CyberSecurity Multi-Agent System - Complete Visualization

This document provides comprehensive visualizations of the CyberSecurity Multi-Agent System architecture, workflows, and data flows.

## 📋 Table of Contents
- [🛡️ CyberSecurity Multi-Agent System - Complete Visualization](#️-cybersecurity-multi-agent-system---complete-visualization)
  - [📋 Table of Contents](#-table-of-contents)
  - [1. System Architecture Overview](#1-system-architecture-overview)
  - [2. Agent Workflow](#2-agent-workflow)
  - [3. Data Flow Diagram](#3-data-flow-diagram)
  - [4. Agent Communication Protocol (A2A)](#4-agent-communication-protocol-a2a)
  - [5. Class Diagram](#5-class-diagram)
  - [6. Sequence Diagram - Complete Scan Process](#6-sequence-diagram---complete-scan-process)
  - [7. Database Schema](#7-database-schema)
  - [8. Deployment Architecture](#8-deployment-architecture)
  - [9. Alert System Flow](#9-alert-system-flow)
  - [10. Technology Stack Visualization](#10-technology-stack-visualization)
  - [🚀 Getting Started](#-getting-started)
  - [📚 Diagram Legend](#-diagram-legend)

---

## 1. System Architecture Overview

```mermaid
graph TB
    subgraph "User Interfaces"
        UI1[Streamlit Dashboard]
        UI2[FastAPI REST API]
    end
    
    subgraph "Core System"
        CA[Controller Agent]
        A2A[A2A Protocol]
        DB[(SQLite Database)]
        LOG[Logger]
    end
    
    subgraph "Specialized Agents"
        TIA[Threat Intel Agent]
        OSA[OSINT Agent]
        CRA[Correlation Agent]
        RAG[RAG Agent]
        RPA[Report Agent]
        ALA[Alert Agent]
        STA[Self Test Agent]
    end
    
    subgraph "External APIs"
        VT[VirusTotal API]
        ABUSE[AbuseIPDB API]
        IPINFO[IPInfo API]
        HIBP[HaveIBeenPwned API]
        HUNTER[Hunter.io API]
        SERP[SerpAPI]
        GEMINI[Google Gemini API]
    end
    
    subgraph "Alert Channels"
        EMAIL[Email SMTP]
        SLACK[Slack Webhook]
        DISCORD[Discord Webhook]
    end
    
    UI1 --> CA
    UI2 --> CA
    CA --> A2A
    A2A --> TIA
    A2A --> OSA
    A2A --> CRA
    A2A --> RAG
    A2A --> RPA
    A2A --> ALA
    A2A --> STA
    
    TIA --> VT
    TIA --> ABUSE
    TIA --> IPINFO
    OSA --> HIBP
    OSA --> HUNTER
    CRA --> GEMINI
    RAG --> SERP
    RAG --> GEMINI
    
    ALA --> EMAIL
    ALA --> SLACK
    ALA --> DISCORD
    
    CA --> LOG
    LOG --> DB
    TIA --> LOG
    
    classDef userInterface fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef coreSystem fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef agent fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef external fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef alert fill:#ffebee,stroke:#b71c1c,stroke-width:2px
    
    class UI1,UI2 userInterface
    class CA,A2A,DB,LOG coreSystem
    class TIA,OSA,CRA,RAG,RPA,ALA,STA agent
    class VT,ABUSE,IPINFO,HIBP,HUNTER,SERP,GEMINI external
    class EMAIL,SLACK,DISCORD alert
```

---

## 2. Agent Workflow

```mermaid
flowchart TD
    START([User Input: IP/Email/Domain]) --> CA[Controller Agent]
    
    CA --> TIA[Threat Intel Agent]
    CA --> OSA[OSINT Agent]
    
    TIA --> VT_SCAN[VirusTotal Scan]
    TIA --> ABUSE_SCAN[AbuseIPDB Scan]
    TIA --> IP_INFO[IPInfo Lookup]
    
    OSA --> EMAIL_CHECK{Input Type}
    EMAIL_CHECK -->|Email| HIBP_CHECK[HaveIBeenPwned Check]
    EMAIL_CHECK -->|Domain| HUNTER_SEARCH[Hunter.io Domain Search]
    
    VT_SCAN --> TIA_RESULT[TIA Results]
    ABUSE_SCAN --> TIA_RESULT
    IP_INFO --> TIA_RESULT
    
    HIBP_CHECK --> OSA_RESULT[OSA Results]
    HUNTER_SEARCH --> OSA_RESULT
    
    TIA_RESULT --> CRA[Correlation Agent]
    OSA_RESULT --> CRA
    
    CRA --> GEMINI_ANALYSIS[Gemini AI Analysis]
    GEMINI_ANALYSIS --> CRA_RESULT[Correlation Results]
    
    TIA_RESULT --> RAG[RAG Agent]
    RAG --> SERP_SEARCH[SerpAPI Web Search]
    RAG --> GEMINI_RAG[Gemini RAG Analysis]
    
    SERP_SEARCH --> RAG_RESULT[RAG Results]
    GEMINI_RAG --> RAG_RESULT
    
    TIA_RESULT --> RPA[Report Agent]
    OSA_RESULT --> RPA
    CRA_RESULT --> RPA
    
    RPA --> REPORT_GEN[Generate MD Report]
    REPORT_GEN --> RPA_RESULT[Report Results]
    
    TIA_RESULT --> STA[Self Test Agent]
    STA --> VALIDATION[Field Validation]
    VALIDATION --> STA_RESULT[Test Results]
    
    TIA_RESULT --> ALA[Alert Agent]
    ALA --> THREAT_CHECK{Threat Level Check}
    THREAT_CHECK -->|High Risk| SEND_ALERTS[Send Multi-Channel Alerts]
    THREAT_CHECK -->|Low Risk| NO_ALERT[No Alert Needed]
    
    SEND_ALERTS --> EMAIL_ALERT[Email Alert]
    SEND_ALERTS --> SLACK_ALERT[Slack Alert]
    SEND_ALERTS --> DISCORD_ALERT[Discord Alert]
    
    EMAIL_ALERT --> ALA_RESULT[Alert Results]
    SLACK_ALERT --> ALA_RESULT
    DISCORD_ALERT --> ALA_RESULT
    NO_ALERT --> ALA_RESULT
    
    TIA_RESULT --> LOG_DB[(Log to Database)]
    OSA_RESULT --> LOG_DB
    CRA_RESULT --> LOG_DB
    RAG_RESULT --> LOG_DB
    RPA_RESULT --> LOG_DB
    STA_RESULT --> LOG_DB
    ALA_RESULT --> LOG_DB
    
    LOG_DB --> END([Scan Complete])
    
    classDef startEnd fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px
    classDef agent fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef process fill:#fff9c4,stroke:#f57f17,stroke-width:2px
    classDef decision fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef external fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    classDef database fill:#e0f2f1,stroke:#00695c,stroke-width:2px
    
    class START,END startEnd
    class CA,TIA,OSA,CRA,RAG,RPA,STA,ALA agent
    class VT_SCAN,ABUSE_SCAN,IP_INFO,HIBP_CHECK,HUNTER_SEARCH,GEMINI_ANALYSIS,SERP_SEARCH,GEMINI_RAG,REPORT_GEN,VALIDATION,SEND_ALERTS,EMAIL_ALERT,SLACK_ALERT,DISCORD_ALERT process
    class EMAIL_CHECK,THREAT_CHECK decision
    class LOG_DB database
```

---

## 3. Data Flow Diagram

```mermaid
graph LR
    subgraph "Input Layer"
        INPUT[User Query<br/>IP/Email/Domain]
    end
    
    subgraph "Processing Layer"
        THREAT[Threat Intelligence<br/>• VirusTotal<br/>• AbuseIPDB<br/>• IPInfo]
        OSINT[OSINT Data<br/>• HaveIBeenPwned<br/>• Hunter.io]
        AI[AI Analysis<br/>• Correlation<br/>• RAG Search<br/>• Gemini AI]
    end
    
    subgraph "Analysis Layer"
        CORR[Correlation Analysis<br/>Cross-reference data<br/>Risk assessment]
        RAG_PROC[RAG Processing<br/>Web search context<br/>Real-time intel]
    end
    
    subgraph "Output Layer"
        REPORT[Security Report<br/>Markdown format<br/>Timestamped]
        ALERTS[Alert System<br/>Email, Slack, Discord<br/>Risk-based triggers]
        LOGS[Database Logs<br/>Audit trail<br/>Historical data]
    end
    
    subgraph "Validation Layer"
        TEST[Self-Testing<br/>Data validation<br/>Quality assurance]
    end
    
    INPUT --> THREAT
    INPUT --> OSINT
    
    THREAT --> CORR
    OSINT --> CORR
    
    THREAT --> RAG_PROC
    CORR --> AI
    RAG_PROC --> AI
    
    THREAT --> REPORT
    OSINT --> REPORT
    AI --> REPORT
    
    THREAT --> ALERTS
    AI --> ALERTS
    
    THREAT --> TEST
    
    THREAT --> LOGS
    OSINT --> LOGS
    AI --> LOGS
    REPORT --> LOGS
    ALERTS --> LOGS
    TEST --> LOGS
    
    classDef input fill:#e8f5e8,stroke:#2e7d32,stroke-width:3px
    classDef processing fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef analysis fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    classDef output fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef validation fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    
    class INPUT input
    class THREAT,OSINT processing
    class CORR,RAG_PROC,AI analysis
    class REPORT,ALERTS,LOGS output
    class TEST validation
```

---

## 4. Agent Communication Protocol (A2A)

```mermaid
sequenceDiagram
    participant User
    participant Controller as Controller Agent
    participant A2A as A2A Protocol
    participant TIA as Threat Intel Agent
    participant OSA as OSINT Agent
    participant CRA as Correlation Agent
    participant RAG as RAG Agent
    participant RPA as Report Agent
    participant ALA as Alert Agent
    participant STA as Self Test Agent
    participant DB as Database
    
    User->>Controller: Input Query (IP/Email/Domain)
    Controller->>A2A: Create message for TIA
    A2A->>TIA: Route threat intel task
    TIA->>TIA: Scan VirusTotal, AbuseIPDB, IPInfo
    TIA->>DB: Log scan results
    TIA-->>A2A: Return threat data
    A2A-->>Controller: Threat intel results
    
    Controller->>A2A: Create message for OSA
    A2A->>OSA: Route OSINT task
    OSA->>OSA: Check HIBP/Hunter.io based on input type
    OSA-->>A2A: Return OSINT data
    A2A-->>Controller: OSINT results
    
    Controller->>A2A: Create message for CRA
    A2A->>CRA: Route correlation task (threat + OSINT data)
    CRA->>CRA: AI analysis with Gemini
    CRA-->>A2A: Return correlation analysis
    A2A-->>Controller: Correlation results
    
    Controller->>A2A: Create message for RAG
    A2A->>RAG: Route RAG task (query + threat data)
    RAG->>RAG: Web search + AI analysis
    RAG-->>A2A: Return RAG analysis
    A2A-->>Controller: RAG results
    
    Controller->>A2A: Create message for RPA
    A2A->>RPA: Route report task (all collected data)
    RPA->>RPA: Generate markdown report
    RPA-->>A2A: Return report info
    A2A-->>Controller: Report results
    
    Controller->>A2A: Create message for STA
    A2A->>STA: Route self-test task (agent results)
    STA->>STA: Validate data integrity
    STA-->>A2A: Return validation results
    A2A-->>Controller: Test results
    
    Controller->>A2A: Create message for ALA
    A2A->>ALA: Route alert task (threat data)
    ALA->>ALA: Check threat levels
    alt High Risk Detected
        ALA->>ALA: Send multi-channel alerts
    end
    ALA-->>A2A: Return alert status
    A2A-->>Controller: Alert results
    
    Controller->>DB: Log complete scan results
    Controller-->>User: Return comprehensive results
```

---

## 5. Class Diagram

```mermaid
classDiagram
    class ControllerAgent {
        -dict agents
        +__init__(**kwargs)
        +run(query: str, scan_id: str) dict
    }
    
    class A2AProtocol {
        +create_message(sender, receiver, task_type, payload) dict
        +route(message, agents) dict
    }
    
    class ThreatIntelAgent {
        -VirusTotalTool vt
        -AbuseIPDBTool abuse
        -IPInfoTool ipinfo
        -DBLogger logger
        +__init__(vt_key, abuse_key, ipinfo_token)
        +handle_task(ip) dict
    }
    
    class OSINTAgent {
        -HaveIBeenPwnedTool hibp_tool
        -HunterIOTool hunter_tool
        -str hibp_key
        +__init__(hibp_key, hunter_key)
        +handle_task(query) dict
    }
    
    class CorrelationAgent {
        -GenerativeModel model
        -str prompt_template
        +__init__(gemini_api_key)
        +handle_task(task_payload) dict
    }
    
    class RAGAgent {
        -SerpAPISearch search_tool
        -GenerativeModel model
        +__init__(serpapi_key, gemini_key)
        +handle_task(payload) dict
    }
    
    class ReportAgent {
        -str template
        +__init__(template_path)
        +handle_task(payload) dict
    }
    
    class AlertAgent {
        -str email_sender
        -str email_pass
        -str recipient
        -str slack_webhook
        -str discord_webhook
        +__init__(email_sender, email_pass, recipient, slack_webhook, discord_webhook)
        +check_and_alert(result) dict
        +send_email_alert(result)
        +send_slack_alert(result)
        +send_discord_alert(result)
    }
    
    class SelfTestAgent {
        -dict required_fields
        +__init__()
        +handle_task(payload) dict
    }
    
    class DBLogger {
        +log_scan(ip, vt_data, abuse_data, ipinfo_data)
        +log_to_db(scan_id, query, results)
        +fetch_all() list
    }
    
    ControllerAgent --> ThreatIntelAgent
    ControllerAgent --> OSINTAgent
    ControllerAgent --> CorrelationAgent
    ControllerAgent --> RAGAgent
    ControllerAgent --> ReportAgent
    ControllerAgent --> AlertAgent
    ControllerAgent --> SelfTestAgent
    ControllerAgent --> A2AProtocol
    ThreatIntelAgent --> DBLogger
    ControllerAgent --> DBLogger
```

---

## 6. Sequence Diagram - Complete Scan Process

```mermaid
sequenceDiagram
    participant UI as User Interface
    participant CA as Controller Agent
    participant TIA as Threat Intel Agent
    participant VT as VirusTotal API
    participant ABUSE as AbuseIPDB API
    participant IPINFO as IPInfo API
    participant OSA as OSINT Agent
    participant HIBP as HaveIBeenPwned API
    participant HUNTER as Hunter.io API
    participant CRA as Correlation Agent
    participant GEMINI as Gemini AI
    participant RAG as RAG Agent
    participant SERP as SerpAPI
    participant RPA as Report Agent
    participant ALA as Alert Agent
    participant STA as Self Test Agent
    participant DB as Database
    
    UI->>CA: initiate_scan(query)
    
    Note over CA,TIA: Threat Intelligence Phase
    CA->>TIA: handle_task(ip)
    TIA->>VT: scan_ip(ip)
    VT-->>TIA: reputation_data
    TIA->>ABUSE: scan_ip(ip)
    ABUSE-->>TIA: abuse_confidence_score
    TIA->>IPINFO: get_info(ip)
    IPINFO-->>TIA: geolocation_data
    TIA->>DB: log_scan(ip, vt_data, abuse_data, ipinfo_data)
    TIA-->>CA: threat_intel_results
    
    Note over CA,OSA: OSINT Phase
    CA->>OSA: handle_task(query)
    alt Email Input
        OSA->>HIBP: check_email(email)
        HIBP-->>OSA: breach_data
    else Domain Input
        OSA->>HUNTER: domain_search(domain)
        HUNTER-->>OSA: domain_info
    end
    OSA-->>CA: osint_results
    
    Note over CA,CRA: Correlation Phase
    CA->>CRA: handle_task(threat_data, osint_data)
    CRA->>GEMINI: generate_content(correlation_prompt)
    GEMINI-->>CRA: ai_analysis
    CRA-->>CA: correlation_results
    
    Note over CA,RAG: RAG Phase
    CA->>RAG: handle_task(query, threat_data)
    RAG->>SERP: search(query)
    SERP-->>RAG: web_results
    RAG->>GEMINI: generate_content(rag_prompt)
    GEMINI-->>RAG: contextual_analysis
    RAG-->>CA: rag_results
    
    Note over CA,RPA: Report Generation Phase
    CA->>RPA: handle_task(all_data)
    RPA->>RPA: generate_markdown_report()
    RPA-->>CA: report_results
    
    Note over CA,STA: Self-Test Phase
    CA->>STA: handle_task(agent_name, results)
    STA->>STA: validate_fields()
    STA->>STA: check_data_quality()
    STA-->>CA: validation_results
    
    Note over CA,ALA: Alert Phase
    CA->>ALA: check_and_alert(threat_results)
    alt High Risk Detected
        ALA->>ALA: send_email_alert()
        ALA->>ALA: send_slack_alert()
        ALA->>ALA: send_discord_alert()
    end
    ALA-->>CA: alert_results
    
    Note over CA,DB: Logging Phase
    CA->>DB: log_to_db(scan_id, query, all_results)
    
    CA-->>UI: complete_scan_results
```

---

## 7. Database Schema

```mermaid
erDiagram
    SCAN_LOGS {
        string scan_id PK
        string ip_address
        json virustotal_data
        json abuseipdb_data
        json ipinfo_data
        json osint_data
        json correlation_data
        json rag_data
        json report_data
        json alert_data
        json selftest_data
        datetime timestamp
        string status
    }
    
    AGENT_LOGS {
        int log_id PK
        string scan_id FK
        string agent_name
        json input_data
        json output_data
        datetime execution_time
        string status
        string error_message
    }
    
    THREAT_INDICATORS {
        int indicator_id PK
        string indicator_value
        string indicator_type
        int threat_score
        json metadata
        datetime first_seen
        datetime last_updated
    }
    
    ALERT_HISTORY {
        int alert_id PK
        string scan_id FK
        string alert_type
        string recipient
        json alert_data
        datetime sent_timestamp
        string delivery_status
    }
    
    SCAN_LOGS ||--o{ AGENT_LOGS : "has"
    SCAN_LOGS ||--o{ ALERT_HISTORY : "triggers"
    SCAN_LOGS }o--|| THREAT_INDICATORS : "references"
```

---

## 8. Deployment Architecture

```mermaid
graph TB
    subgraph "Client Layer"
        WEB[Web Browser]
        API_CLIENT[API Client]
    end
    
    subgraph "Application Layer"
        STREAMLIT[Streamlit Dashboard<br/>Port 8501]
        FASTAPI[FastAPI Server<br/>Port 8000]
    end
    
    subgraph "Core Processing"
        CONTROLLER[Controller Agent]
        AGENTS[Agent Pool<br/>• ThreatIntel<br/>• OSINT<br/>• Correlation<br/>• RAG<br/>• Report<br/>• Alert<br/>• SelfTest]
    end
    
    subgraph "Data Layer"
        SQLITE[(SQLite Database<br/>logs.db)]
        FILES[File System<br/>Reports & Logs]
    end
    
    subgraph "External Services"
        THREAT_APIS[Threat Intel APIs<br/>• VirusTotal<br/>• AbuseIPDB<br/>• IPInfo]
        OSINT_APIS[OSINT APIs<br/>• HaveIBeenPwned<br/>• Hunter.io]
        AI_SERVICES[AI Services<br/>• Google Gemini<br/>• SerpAPI]
        ALERT_SERVICES[Alert Services<br/>• SMTP Email<br/>• Slack Webhook<br/>• Discord Webhook]
    end
    
    WEB --> STREAMLIT
    API_CLIENT --> FASTAPI
    
    STREAMLIT --> CONTROLLER
    FASTAPI --> CONTROLLER
    
    CONTROLLER --> AGENTS
    
    AGENTS --> SQLITE
    AGENTS --> FILES
    
    AGENTS --> THREAT_APIS
    AGENTS --> OSINT_APIS
    AGENTS --> AI_SERVICES
    AGENTS --> ALERT_SERVICES
    
    classDef client fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef app fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef core fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef data fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef external fill:#ffebee,stroke:#b71c1c,stroke-width:2px
    
    class WEB,API_CLIENT client
    class STREAMLIT,FASTAPI app
    class CONTROLLER,AGENTS core
    class SQLITE,FILES data
    class THREAT_APIS,OSINT_APIS,AI_SERVICES,ALERT_SERVICES external
```

---

## 9. Alert System Flow

```mermaid
flowchart TD
    START[Threat Analysis Complete] --> EVAL{Evaluate Threat Level}
    
    EVAL -->|AbuseIPDB Score > 50| HIGH_RISK[High Risk Detected]
    EVAL -->|VirusTotal Rep < 0| HIGH_RISK
    EVAL -->|Low Risk| NO_ALERT[No Alert Required]
    
    HIGH_RISK --> EMAIL_PREP[Prepare Email Alert]
    HIGH_RISK --> SLACK_PREP[Prepare Slack Alert]
    HIGH_RISK --> DISCORD_PREP[Prepare Discord Alert]
    
    EMAIL_PREP --> EMAIL_SEND[Send via SMTP<br/>Gmail 465 SSL]
    SLACK_PREP --> SLACK_SEND[Send via Webhook<br/>POST Request]
    DISCORD_PREP --> DISCORD_SEND[Send via Webhook<br/>POST Request]
    
    EMAIL_SEND --> EMAIL_STATUS{Email Sent?}
    SLACK_SEND --> SLACK_STATUS{Slack Sent?}
    DISCORD_SEND --> DISCORD_STATUS{Discord Sent?}
    
    EMAIL_STATUS -->|Success| EMAIL_LOG[Log Email Success]
    EMAIL_STATUS -->|Failure| EMAIL_ERROR[Log Email Error]
    
    SLACK_STATUS -->|Success| SLACK_LOG[Log Slack Success]
    SLACK_STATUS -->|Failure| SLACK_ERROR[Log Slack Error]
    
    DISCORD_STATUS -->|Success| DISCORD_LOG[Log Discord Success]
    DISCORD_STATUS -->|Failure| DISCORD_ERROR[Log Discord Error]
    
    EMAIL_LOG --> COMPLETE[Alert Process Complete]
    EMAIL_ERROR --> COMPLETE
    SLACK_LOG --> COMPLETE
    SLACK_ERROR --> COMPLETE
    DISCORD_LOG --> COMPLETE
    DISCORD_ERROR --> COMPLETE
    NO_ALERT --> COMPLETE
    
    classDef start fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px
    classDef decision fill:#fff9c4,stroke:#f57f17,stroke-width:2px
    classDef process fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef success fill:#e8f5e8,stroke:#4caf50,stroke-width:2px
    classDef error fill:#ffebee,stroke:#f44336,stroke-width:2px
    classDef complete fill:#f3e5f5,stroke:#9c27b0,stroke-width:3px
    
    class START start
    class EVAL,EMAIL_STATUS,SLACK_STATUS,DISCORD_STATUS decision
    class HIGH_RISK,EMAIL_PREP,SLACK_PREP,DISCORD_PREP,EMAIL_SEND,SLACK_SEND,DISCORD_SEND,NO_ALERT process
    class EMAIL_LOG,SLACK_LOG,DISCORD_LOG success
    class EMAIL_ERROR,SLACK_ERROR,DISCORD_ERROR error
    class COMPLETE complete
```

---

## 10. Technology Stack Visualization

```mermaid
graph LR
    subgraph "Frontend"
        ST[Streamlit 1.28.0<br/>Interactive Dashboard]
        FA[FastAPI 0.115.2<br/>REST API Server]
    end
    
    subgraph "Backend Core"
        PY[Python 3.x<br/>Core Runtime]
        PD[Pydantic 2.7.4<br/>Data Validation]
        UV[Uvicorn 0.20.0<br/>ASGI Server]
    end
    
    subgraph "AI & ML"
        GEMINI[Google Generative AI 0.3.0<br/>LLM Analysis]
        OPENAI[OpenAI 1.86.0<br/>Alternative LLM]
    end
    
    subgraph "Data Processing"
        PANDAS[Pandas 2.0.0<br/>Data Analysis]
        NUMPY[NumPy 1.24.0<br/>Numerical Computing]
        REQ[Requests 2.32.0<br/>HTTP Client]
    end
    
    subgraph "Security APIs"
        AIOHTTP[aiohttp 3.8.0<br/>Async HTTP]
        THROTTLE[asyncio-throttle 1.0.0<br/>Rate Limiting]
    end
    
    subgraph "Visualization"
        MPLOT[Matplotlib 3.7.0<br/>Plotting]
        SEABORN[Seaborn 0.12.0<br/>Statistical Viz]
        PLOTLY[Plotly 5.15.0<br/>Interactive Charts]
    end
    
    subgraph "Database & Logging"
        SQLITE[SQLite3<br/>Local Database]
        LOGURU[Loguru 0.7.0<br/>Structured Logging]
    end
    
    subgraph "Reporting"
        MD[Markdown 3.5.0<br/>Report Generation]
        PDF[ReportLab 4.0.0<br/>PDF Export]
        YAML[PyYAML 6.0.0<br/>Config Files]
    end
    
    ST --> PY
    FA --> PY
    PY --> PD
    FA --> UV
    
    PY --> GEMINI
    PY --> OPENAI
    
    PY --> PANDAS
    PY --> NUMPY
    PY --> REQ
    
    PY --> AIOHTTP
    PY --> THROTTLE
    
    PY --> MPLOT
    PY --> SEABORN
    PY --> PLOTLY
    
    PY --> SQLITE
    PY --> LOGURU
    
    PY --> MD
    PY --> PDF
    PY --> YAML
    
    classDef frontend fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef backend fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef ai fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    classDef data fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef security fill:#ffebee,stroke:#b71c1c,stroke-width:2px
    classDef viz fill:#f9fbe7,stroke:#827717,stroke-width:2px
    classDef db fill:#e0f2f1,stroke:#00695c,stroke-width:2px
    classDef report fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    
    class ST,FA frontend
    class PY,PD,UV backend
    class GEMINI,OPENAI ai
    class PANDAS,NUMPY,REQ data
    class AIOHTTP,THROTTLE security
    class MPLOT,SEABORN,PLOTLY viz
    class SQLITE,LOGURU db
    class MD,PDF,YAML report
```

---

## 🚀 Getting Started

To visualize these diagrams in your development environment:

1. **Install Mermaid CLI** (optional for PNG/SVG export):
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

2. **Use Mermaid Live Editor**: https://mermaid.live/

3. **VS Code Extension**: Install "Mermaid Markdown Syntax Highlighting"

4. **GitHub/GitLab**: These diagrams render automatically in markdown files

---

## 📚 Diagram Legend

- **Blue**: User interfaces and entry points
- **Purple**: Core system components
- **Green**: Processing agents and AI components
- **Orange**: External APIs and services
- **Red**: Alert and notification systems
- **Teal**: Database and storage components

---

*This visualization document is automatically updated with the system architecture. Last updated: June 25, 2025*
