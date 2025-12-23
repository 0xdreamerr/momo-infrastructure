output "internal_ips" {
  value = {
    for k, vm in yandex_compute_instance.vm :
    k => vm.network_interface[0].ip_address
  }
}