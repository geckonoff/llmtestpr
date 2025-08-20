variable "vm_name" {
  type    = string
  default = "ubuntu"
}

variable "cpu" {
  type    = number
  default = 4
}

variable "ram" {
  type    = number
  default = 8192
}

variable "disk_size" {
  type    = string
  default = "40G"
}

variable "iso_url" {
  type    = string
}

variable "iso_checksum" {
  type    = string
}