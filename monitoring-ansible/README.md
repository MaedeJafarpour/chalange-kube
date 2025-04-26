# Enterprise Monitoring System with Adaptive Metric Collection

![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=Prometheus&logoColor=white)
![Grafana](https://img.shields.io/badge/grafana-%23F46800.svg?style=for-the-badge&logo=grafana&logoColor=white)

## 🕵️ Smart Metric Collection System
**Context-aware monitoring solution that automatically adapts to environment components while preventing logging subsystem crashes**

## 🌟 Key Features
- **Intelligent Agent Auto-Configuration**
  - Automatic detection of Docker/Kubernetes environments
  - Safe fallback to system metrics when containers not present
  - Crash-resistant logging pipeline with Loki buffering
- **Central Monitoring Hub**
  - Prometheus TSDB with 3-year retention policy
  - Grafana 10+ with pre-configured production dashboards
  - Alertmanager with PagerDuty/Slack integration
- **Adaptive Data Collection**
  - Container-aware metrics via cAdvisor (when Docker present)
  - Kubernetes API server monitoring (when K8s detected)
  - Systemd journal collection with log rotation safeguards
- **Security First**
  - TLS-encrypted metric transport
  - Service account-based authentication
  - RBAC-enabled access controls

## 🧩 Integration Ecosystem
```mermaid
graph TD
    A[Alloy Agent] --> B[Prometheus]
    A --> C[Loki]
    B --> D[Alertmanager]
    B --> E[Grafana]
    C --> E
    D --> F[PagerDuty]
    D --> G[Slack]
    D --> H[Telegram]
    E --> I[Enterprise SIEM]
    style H fill:#0088cc,color:#ffffff


## 🏗️ Architecture Overview
```bash
Monitoring Stack
├── Main Server (1+ HA Nodes)
│   ├─ Prometheus 2.45+    # Time series database
│   ├─ Alertmanager 0.26+  # Alert routing & deduplication
│   ├─ Grafana 10.1+       # Visualization & dashboards
│   └─ Loki 2.9+           # Log aggregation
│
└── Agent Servers (All Nodes)
    └─ Alloy 1.0+          # Dynamic metric collection
       ├─ System Metrics   # Always collected
       ├─ Docker Metrics   # Auto-enabled when detected
       └─ K8s Metrics      # Auto-enabled when detected


also VM identification through node fingerprinting with lable nodename(static) and hostname(in ansible host)





