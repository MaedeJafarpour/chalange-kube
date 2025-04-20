resource "proxmox_vm_qemu" "worker" {
  count       = var.node_count
  name        = "k8s-worker-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.vm_template
  agent       = 1
  os_type     = "cloud-init"
  qemu_os     = "l26"

  # Hardware
  cores  = var.cores
  memory = var.memory
  cpu    = "host"

  # Storage
  disk {
    size     = var.disk_size
    type     = "scsi"
    storage  = var.storage_pool
    iothread = true
  }

  # Network
  network {
    model  = "virtio"
    bridge = var.network_bridge
  }

  # Cloud-Init
  ipconfig0    = "ip=${cidrhost(var.network_cidr, var.ip_start + count.index)}/${var.network_prefix},gw=${var.gateway}"
  nameserver   = join(" ", var.dns_servers)
  ciuser       = "ubuntu"
  sshkeys      = file(var.ssh_key_path)

  lifecycle {
    ignore_changes = [
      network,
      disk,
      desc
    ]
  }
}
