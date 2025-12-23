resource "yandex_compute_instance" "vm" {
  for_each = var.instances

  name = each.key
  zone = var.zone

  resources {
    cores  = each.value.cores
    memory = each.value.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  scheduling_policy {
     preemptible = var.preemptible
  }

}