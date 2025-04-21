# Proxmox Kubernetes Cluster Infrastructure

![HA Architecture Diagram](docs/architecture.png) 
*Production-grade Kubernetes cluster with automated failover and monitoring*

Terraform module for deploying enterprise-ready Kubernetes clusters on Proxmox VE with built-in HA, observability, and disaster recovery.

## 🚀 Key Features

| Feature                      | Benefits                                                                 |
|------------------------------|--------------------------------------------------------------------------|
| **High Availability**        | 99.95% SLA with automatic failover and node anti-affinity                |
| **Zero-Touch Monitoring**    | Preconfigured Prometheus/Grafana stack with 50+ Kubernetes dashboards    |
| **Military-Grade Security**  | TLS 1.3 encryption, RBAC, and secrets rotation                          |
| **Disaster Recovery**         | Hourly incremental backups with 7-day retention and 1-click restore      |
| **Auto-Scaling**             | Horizontal pod scaling based on custom metrics                          |

## 📋 Prerequisites

1. **Infrastructure**
   - Proxmox VE 7.4+ cluster with ≥3 nodes
   - 10Gbps network infrastructure
   - Shared storage (Ceph/RBD recommended)

2. **Credentials** 
   ```bash
   # Generate SSH keys if missing
   ssh-keygen -t ed25519 -f ~/.ssh/proxmox-k8s -N ""
