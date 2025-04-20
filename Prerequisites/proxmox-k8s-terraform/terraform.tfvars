# Proxmox Connection
pm_api_url          = "https://192.168.1.100:8006/"
pm_user             = "root@pam"
pm_api_token_id     = "root@pam!terraform-0"
pm_api_token_secret = "5ad0abb9-5e48-4353-afc7-aed523ec128a"

# Infrastructure Configuration
proxmox_node  = "pve"
vm_template   = "ubuntu-2204-cloudinit-template"
storage_pool  = "local-lvm"

# Network Configuration
network_config = {
  bridge      = "vmbr0"
  cidr        = "192.168.1.0/24"
  gateway     = "192.168.1.1"
  dns_servers = ["192.168.1.1"]
}

# SSH Configuration
ssh_config = {
  key_path    = "~/.ssh/id_rsa.pub"
  agent       = true
  username    = "ubuntu"
}

# HA Configuration
ha_config = {
  enabled          = true
  ha_group         = "k8s-cluster"
  migration_policy = "manual"
}

# Master Nodes
masters = {
  count     = 3
  cores     = 2
  memory    = 8192
  disk_size = "50G"
  ip_start  = 100
}

# Worker Nodes
workers = {
  count     = 2
  cores     = 4
  memory    = 16384
  disk_size = "80G"
  ip_start  = 110
}

