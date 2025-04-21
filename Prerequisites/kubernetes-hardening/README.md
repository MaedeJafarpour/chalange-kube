# Ansible System Hardening Framework 🔒

**Enterprise-Grade Security Automation for Linux & Kubernetes**  
*CIS Benchmark-Compliant · Idempotent · Production-Tested*

---

## Features 🛡️
- **CIS Benchmark Enforcement** (Level 1/2 controls)
- **Kubernetes-Specific Hardening** (PSPs, API restrictions)
- **Defense-in-Depth Architecture**  
  ```mermaid
  graph TD
    A[Network Layer] -->|Firewalld Rules| B[OS Layer]
    B -->|SSH/Kernel Hardening| C[K8s Layer]
    C -->|Pod Security| D[App Layer]
