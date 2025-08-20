packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.9"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu" {
  qemu_binary     = "/usr/bin/qemu-system-x86_64"
  accelerator     = "kvm"      # если nested KVM вдруг не работает, поменяешь на "none"
  headless        = true

  iso_url         = var.iso_url
  iso_checksum    = var.iso_checksum

  ssh_username    = "packer"
  ssh_password    = "packer"
  ssh_timeout     = "30m"

  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"

  disk_size       = var.disk_size
  format          = "qcow2"
  vm_name         = var.vm_name
  cpus            = var.cpu
  memory          = var.ram
  net_device      = "virtio-net"
  disk_interface  = "virtio"

  http_directory  = "http"

  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz --- autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "<enter>",
    "initrd /casper/initrd",
    "<enter>",
    "boot",
    "<enter>"
  ]
}

build {
  name    = "ubuntu"
  sources = ["source.qemu.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt -y upgrade",
      "sudo apt -y install qemu-guest-agent build-essential python3 python3-pip git"
    ]
  }

  post-processor "shell-local" {
    inline = ["echo 'Образ {{build_name}} готов: output/{{build_name}}.qcow2'"]
  }
}