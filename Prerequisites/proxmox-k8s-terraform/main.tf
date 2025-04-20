provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_user             = var.pm_user
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true # In prod, use valid CA cert
  pm_timeout          = 600  # Increased timeout for HA operations
}

# HA Group Configuration
resource "proxmox_vm_qemu" "ha_group" {
  count = var.ha_config.enabled ? 1 : 0
  
  hagroup    = var.ha_config.ha_group
  nodes      = [var.proxmox_node]
  restriction = "nodes=${var.proxmox_node}"
  type       = "vm"
}

module "k8s_masters" {
  source = "./modules/master"

  # Proxmox Configuration
  proxmox_node   = var.proxmox_node
  vm_template    = var.vm_template
  storage_pool   = var.storage_pool
  api_token      = "${var.pm_api_token_id}=${var.pm_api_token_secret}"
  
  # Cluster Configuration
  node_count     = var.masters.count
  cores          = var.masters.cores
  memory         = var.masters.memory
  disk_size      = var.masters.disk_size
  ip_start       = var.masters.ip_start
  ha_enabled     = var.ha_config.enabled
  ha_group       = var.ha_config.ha_group

  # Network
  network_config = var.network_config
  ssh_config     = var.ssh_config
}

module "k8s_workers" {
  source = "./modules/worker"

  # Proxmox Configuration
  proxmox_node   = var.proxmox_node
  vm_template    = var.vm_template
  storage_pool   = var.storage_pool
  
  # Cluster Configuration
  node_count     = var.workers.count
  cores          = var.workers.cores
  memory         = var.workers.memory
  disk_size      = var.workers.disk_size
  ip_start       = var.workers.ip_start

  # Network
  network_config = var.network_config
  ssh_config     = var.ssh_config

  depends_on = [module.k8s_masters]
}

# Load Balancer for Control Plane
resource "proxmox_vm_qemu" "load_balancer" {
  name        = "k8s-lb-01"
  target_node = var.proxmox_node
  clone       = var.vm_template
  agent       = 1
  cores       = 2
  memory      = 4096

  disk {
    size     = "20G"
    storage  = var.storage_pool
    type     = "scsi"
  }

  network {
    model  = "virtio"
    bridge = var.network_config.bridge
  }

  ipconfig0 = "ip=${cidrhost(var.network_config.cidr, 90)}/24,gw=${var.network_config.gateway}"
  
  lifecycle {
    ignore_changes = [network, disk]
  }

  connection {
    type        = "ssh"
    user        = var.ssh_config.username
    private_key = file(replace(var.ssh_config.key_path, ".pub", ""))
    host        = self.default_ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y haproxy",
      templatefile("${path.module}/templates/haproxy.cfg", {
        masters = module.k8s_masters.master_ips
      })
    ]
  }
}
