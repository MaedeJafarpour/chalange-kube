koutput "worker_ips" {
  description = "IP addresses of worker nodes"
  value = {
    for vm in proxmox_vm_qemu.worker :
    vm.name => vm.default_ipv4_address
  }
}

output "worker_capacity" {
  description = "Resource capacity of workers"
  value = [for vm in proxmox_vm_qemu.worker : {
    name   = vm.name
    cpu    = "${vm.cores}vCPU"
    memory = "${vm.memory}MB"
    disk   = vm.disk[0].size
  }]
}
