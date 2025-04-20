output "master_ips" {
  description = "IP addresses of master nodes"
  value = {
    for vm in proxmox_vm_qemu.master :
    vm.name => vm.default_ipv4_address
  }
}

output "master_names" {
  description = "Names of master nodes"
  value = [for vm in proxmox_vm_qemu.master : vm.name]
}

output "etcd_volumes" {
  description = "ETCD volume information"
  value = [for vm in proxmox_vm_qemu.master : {
    name = vm.name
    etcd = vm.disk[1].size
  }]
}
