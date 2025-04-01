# Prerequisites

Before starting the project, ensure you have the following:

## 1.1 Kubernetes Cluster
Ensure you have a Kubernetes cluster set up (latest version). If not, you can follow the [Kubernetes Installation Guide](https://kubernetes.io/docs/setup/).

### Steps:
- Use tools like `kubeadm` or managed services like EKS, GKE, or AKS to provision the cluster.(use ansible to set up kube with kubeadm or kubespry)

## 1.2 Terraform Installed
You’ll need Terraform for provisioning infrastructure. You can download and install it from the official site: [Terraform Installation Guide](https://www.terraform.io/downloads).

### Steps:
- Install Terraform by following the instructions on the official website.

## 1.3 Ansible Setup
Ansible is used to automate Kubernetes configurations. Install Ansible with the following command:

```bash
pip install ansible
