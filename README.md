**HA Kubernetes Cluster Project**
This project automates the deployment and management of a high-availability Kubernetes cluster using Ansible, Terraform, and Proxmox. It includes configuration for multi-master, multi-worker setups, security configurations, and tools for monitoring, logging, and backup management.

**Overview**
This repository contains the scripts and configuration to deploy a high-availability Kubernetes cluster using multiple tools. The project is structured into three main parts:

1.Ansible-based Kubernetes Setup: Handles Kubernetes installation and configuration.

2.Security Hardening: Ensures that the cluster is secure with configurations for firewalls, SSH, and kernel settings.

3.Terraform & Proxmox Setup: Deploys the infrastructure for Kubernetes clusters using Proxmox and manages it with Terraform.

This setup is ideal for real-time, production-level Kubernetes environments, and it follows best practices for scalability and security.




**Prerequisites**

Tools Required
*Ansible: Used for automating the configuration of your Kubernetes cluster.

*Terraform: Used for provisioning infrastructure (via Proxmox).

*Proxmox: Used for managing virtual machines.

*Kubernetes: Core of the cluster setup.



**Environment Setup**
Ensure that the following software is installed before proceeding with the installation:

Ansible (2.x or higher)

Terraform (v0.13 or higher)

Proxmox (configured and running)

Access to a Kubernetes-compatible environme




1. Clone the repository
```bash
git clone https://github.com/MaedeJafarpour/chalange-kube
cd ha-kubernetes-cluster







