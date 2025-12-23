variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 4
}

variable "disk_size" {
  type    = number
  default = 50
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "subnet_id" {
  type    = string
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "zone" {
  type    = string
  default = "ru-central1-d"
}

variable "image_id" {
  type    = string
}

variable "instances" {
  type = map(object({
    cores  = number
    memory = number
    role   = string
  }))
}