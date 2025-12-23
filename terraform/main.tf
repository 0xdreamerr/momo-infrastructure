data "yandex_compute_image" "ubuntu22_04" {
  family = "ubuntu-2204-lts"
}

module "network" {
  source = "./modules/network"

  network      = var.network
  subnet       = var.subnet
  zone         = var.zone
  subnet_v4_cidr_blocks  = var.subnet_v4_cidr_blocks
}

module "instance" {
  source = "./modules/instance"

  instances   = var.instances
  zone        = var.zone
  subnet_id   = module.network.subnet_id

  image_id    = data.yandex_compute_image.ubuntu22_04.id
  disk_size   = var.disk_size
  preemptible = var.preemptible
}

output "vm_internal_ips" {
  value = module.instance.internal_ips
}
