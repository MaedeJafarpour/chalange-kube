variable "enable_ha" {
  type        = bool
  default     = true
  description = "Enable Proxmox HA for master nodes"
}

variable "etcd_volume_size" {
  type        = string
  default     = "10G"
  description = "Size of etcd dedicated volume"
}
