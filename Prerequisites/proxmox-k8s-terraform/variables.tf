variable "pm_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "pm_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "pm_node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "master_nodes" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "worker_nodes" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "vm_template" {
  description = "VM template to clone"
  type        = string
  default     = "ubuntu-2204-cloudinit-template"
}

variable "vm_network" {
  description = "Network bridge to use"
  type        = string
  default     = "vmbr0"
}


variable "ssh_key" {
  description = "SSH public key"
  type        = string
}
variable "pm_user" {
  description = "Proxmox API user"
  type        = string
}
variable "proxmox_node" {
  description = "Name of the Proxmox node to create VMs on"
  type        = string
  default     = "pve"  # Change to your Proxmox node name
}

variable "template_name" {
  description = "Name of the VM template to clone"
  type        = string
  default     = "ubuntu-2204-cloudinit"  # Change to your template
}

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "master_vm_settings" {
  type = object({
    cores   = number
    memory  = number
    storage = string
    disk_size = string
  })
  default = {
    cores   = 2
    memory  = 4096
    storage = "local-lvm"
    disk_size = "20G"
  }
}

variable "worker_vm_settings" {
  type = object({
    cores   = number
    memory  = number
    storage = string
    disk_size = string
  })
  default = {
    cores   = 4
    memory  = 8192
    storage = "local-lvm"
    disk_size = "30G"
  }
}
