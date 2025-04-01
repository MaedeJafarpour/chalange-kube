output "master_ips" {
  value = {
    for vm in proxmox_vm_qemu.k8s_master :
    vm.name => vm.default_ipv4_address
  }
}

output "worker_ips" {
  value = {
    for vm in proxmox_vm_qemu.k8s_worker :
    vm.name => vm.default_ipv4_address
  }
}


