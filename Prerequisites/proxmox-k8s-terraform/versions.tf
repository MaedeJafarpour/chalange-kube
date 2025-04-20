terraform {
  required_version = ">= 1.5.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.0" # Pinned version
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2" # For provisioners
    }
  }
}
