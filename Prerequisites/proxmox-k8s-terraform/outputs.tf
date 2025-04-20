output "cluster_endpoints" {
  description = "Kubernetes cluster access endpoints"
  value = {
    load_balancer_ip = proxmox_vm_qemu.load_balancer.default_ipv4_address
    masters          = module.k8s_masters.master_ips
    workers          = module.k8s_workers.worker_ips
  }
  sensitive = true
}

output "ha_status" {
  description = "Proxmox HA status"
  value = var.ha_config.enabled ? {
    ha_group  = var.ha_config.ha_group
    members   = module.k8s_masters.master_names
    policy    = var.ha_config.migration_policy
  } : null
}

output "monitoring_endpoints" {
  description = "Monitoring stack access URLs"
  value = {
    prometheus = "http://${proxmox_vm_qemu.load_balancer.default_ipv4_address}:9090"
    grafana    = "http://${proxmox_vm_qemu.load_balancer.default_ipv4_address}:3000"
    alertmanager = "http://${proxmox_vm_qemu.load_balancer.default_ipv4_address}:9093"
  }
}

output "backup_schedule" {
  description = "Cluster backup schedule"
  value = {
    masters = var.masters.backup_policy
    workers = var.workers.backup_policy
  }
}
