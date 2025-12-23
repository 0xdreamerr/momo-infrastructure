terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "std-int-009-04-tfstate"
    region = "ru-central1"
    key    = "momo-store/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone      = var.zone
  folder_id = "b1g83kbhflv03k6koelr"
}