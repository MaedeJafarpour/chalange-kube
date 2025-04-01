terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = ">= 3.0.0"
    }
  }
}
provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
#  pm_password     = ""
  pm_tls_insecure = true
}


#module "master" {
#  source = "./templates/master"
#}
#
#module "worker" {
#  source = "./templates/worker"
#}



 #master node configuration
resource "proxmox_vm_qemu" "k8s_master" {
  agent       = 1
  qemu_os     = "l26" 
  clone       = "ubuntu-2204-cloudinit-template"
  count       = var.master_nodes
  name        = "k8s-master-${count.index + 1}"
  target_node = var.pm_node_name
#  clone       = var.vm_template
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  cpu_type = "host"
  memory      = 8192
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"


  disk {
    slot     = "scsi0"
    size     = "50G"
    type     = "disk"
    storage  = "local-lvm"
    iothread = true
  }
  


  network {
    id     = 0        # Corrected to numeric ID
    model  = "virtio"
    bridge = "vmbr0"
  }




  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 = "ip=192.168.1.${count.index + 100}/24,gw=192.168.1.1"

  ciuser  = "ubuntu"
  sshkeys = file("~/.ssh/id_rsa.pub")
}

# worker node configuration
resource "proxmox_vm_qemu" "k8s_worker" {
  clone       = "ubuntu-2204-cloudinit-template"
  count       = var.worker_nodes
  name        = "k8s-worker-${count.index + 1}"
  target_node = var.pm_node_name
#  clone       = var.vm_template
  agent       = 1
  os_type     = "cloud-init"
  cores       = 4
  sockets     = 1
  cpu_type    = "host"
  memory      = 16384
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"

  disk {
    slot     = "scsi0"
    size     = "50G"
    type     = "disk"
    storage  = "local-lvm"
    iothread = true
  }


  network {
    id     = 0        # Corrected to numeric ID
    model  = "virtio"
    bridge = "vmbr0"
  }




  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.1.${count.index + 100}/24,gw=192.168.1.1"

  ciuser  = "ubuntu"
  sshkeys = file("~/.ssh/id_rsa.pub")
}



