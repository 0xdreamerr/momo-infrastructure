variable "network" {
  type    = string
  default = "ya-network"
}

variable "subnet" {
  type    = string
  default = "ya-subnet"
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "subnet_v4_cidr_blocks" {
  type    = list(string)
  default = ["192.168.10.0/24"]
}

variable "name" {
  type    = string
  default = "vm"
}

variable "cores" {
  type    = number
  default = 4
}

variable "memory" {
  type    = number
  default = 8
}

variable "disk_size" {
  type    = number
  default = 50
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "instances" {
  type = map(object({
    cores  = number
    memory = number
    role   = string
  }))
}
