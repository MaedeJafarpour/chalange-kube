# Proxmox Connection Configuration
variable "pm_api_url" {
  type        = string
  description = "Proxmox API endpoint URL (format: https://host:port/)"
  validation {
    condition     = can(regex("^https://.*:\\d+/?$", var.pm_api_url))
    error_message = "Must be a valid HTTPS URL with port number"
  }
}

variable "pm_user" {
  type        = string
  description = "Proxmox authentication user (format: user@realm)"
  validation {
    condition     = can(regex(".+@.+", var.pm_user))
    error_message = "Must be in user@realm format"
  }
}

variable "pm_api_token_id" {
  type        = string
  sensitive   = true
  description = "Proxmox API token ID (format: user@realm!token-name)"
  validation {
    condition     = can(regex(".+@.+!.+", var.pm_api_token_id))
    error_message = "Must be in user@realm!token-name format"
  }
}

variable "pm_api_token_secret" {
  type        = string
  sensitive   = true
  description = "Proxmox API token secret (UUID format)"
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.pm_api_token_secret))
    error_message = "Must be a valid UUID format"
  }
}

# Proxmox Infrastructure Configuration
variable "proxmox_node" {
  type        = string
  default     = "pve"
  description = "Target Proxmox cluster node name"
}

variable "storage_pool" {
  type        = string
  default     = "local-lvm"
  description = "Default storage pool for VM disks"
}

variable "vm_template" {
  type        = string
  default     = "ubuntu-2204-cloudinit-template"
  description = "Source VM template name for cloning"
}

# Network Configuration
variable "network_config" {
  type = object({
    bridge      = string
    cidr        = string
    gateway     = string
    dns_servers = list(string)
    vlan_tag    = optional(number)
  })
  description = "Network configuration for cluster nodes"
  default = {
    bridge      = "vmbr0"
    cidr        = "192.168.1.0/24"
    gateway     = "192.168.1.1"
    dns_servers = ["192.168.1.1"]
  }
  validation {
    condition     = can(cidrhost(var.network_config.cidr, 0))
    error_message = "Must be a valid CIDR notation"
  }
}

# SSH Configuration
variable "ssh_config" {
  type = object({
    key_path     = string
    agent        = bool
    username     = string
    sudo_password = optional(string, "")
  })
  description = "SSH configuration for node access"
  default = {
    key_path = "~/.ssh/id_rsa.pub"
    agent    = true
    username = "ubuntu"
  }
  sensitive = true
}

# High Availability Configuration
variable "ha_config" {
  type = object({
    enabled          = bool
    ha_group         = string
    migration_policy = string
    backup_schedule  = optional(string)
  })
  description = "Proxmox HA configuration"
  default = {
    enabled          = true
    ha_group         = "k8s-cluster"
    migration_policy = "manual"
  }
}

# Master Node Configuration
variable "masters" {
  type = object({
    count        = number
    cores        = number
    memory       = number
    disk_size    = string
    ip_start     = number
    cpu_type     = optional(string, "host")
    ballooning   = optional(bool, false)
    backup_policy = optional(string, "daily")
  })
  description = "Configuration for Kubernetes master nodes"
  default = {
    count     = 3
    cores     = 2
    memory    = 8192
    disk_size = "50G"
    ip_start  = 100
  }
  validation {
    condition     = var.masters.count >= 1 && var.masters.count <= 5
    error_message = "Master count must be between 1-5 for HA"
  }
}

# Worker Node Configuration
variable "workers" {
  type = object({
    count          = number
    cores          = number
    memory         = number
    disk_size      = string
    ip_start       = number
    cpu_type       = optional(string, "host")
    ballooning     = optional(bool, true)
    scaling_policy = optional(string, "balanced")
  })
  description = "Configuration for Kubernetes worker nodes"
  default = {
    count     = 2
    cores     = 4
    memory    = 16384
    disk_size = "80G"
    ip_start  = 110
  }
}



variable "monitoring" {
  type = object({
    enabled          = bool
    storage_retention = string
    admin_password   = string
  })
  description = "Monitoring stack configuration"
  default = {
    enabled          = true
    storage_retention = "30d"
    admin_password   = "ChangeMe123!"
  }
  sensitive = true
}
