# Production-Grade Kubernetes Cluster on Proxmox

![HA Cluster Architecture](docs/ha-cluster.png) 
*Highly Available Kubernetes Cluster with Automated Monitoring and Backup*

## Features

- **Military-Grade Security** 🔒 
  - Vault-Integrated Secrets Management
  - Automated Certificate Rotation
  - CIS-Hardened Node Images

- **Zero-Downtime Operations** 🕒 
  - Rolling Control Plane Updates
  - Proxmox HA Group Integration
  - Priority-Based Failover (1-5)
  - Anti-Affinity Rules

- **Observability Stack** 📊 
  - Prometheus/Grafana Monitoring
  - Loki/Promtail Logging
  - Alertmanager Integration
  - Prebuilt K8s Dashboards

- **Disaster Recovery** ⚡ 
  - Hourly ZSTD-Compressed Backups
  - 7-Day Retention Policy
  - 1-Click Cluster Restoration
  - Cross-Datacenter Replication

## Prerequisites

| Component              | Requirement                          |
|------------------------|--------------------------------------|
| Proxmox VE Version     | 8.1+                                |
| Terraform Version      | 1.6.6+                              |
| Storage                | 100GB+ Fast Storage (NVMe Preferred)|
| Network                | 10Gbps Recommended                  |
| API Permissions        | VM.Allocate, Datastore.Allocate     |

## Quick Deployment

```bash
# Clone repository
git clone https://github.com/MaedeJafarpour/chalange-kube/tree/main/Prerequisites/proxmox-k8s-terraform  && cd proxmox-k8s-terraform

# Initialize secrets (never commit these!)
echo 'pm_api_token_secret = "your_s3cr3t"' > terraform.tfvars  change paste your variable here like :
pm_api_url , pm_user , ... 
chmod 600 terraform.tfvars

# Deploy cluster
terraform init && terraform apply -auto-approve
