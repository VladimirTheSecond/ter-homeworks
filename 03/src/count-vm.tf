data "yandex_compute_image" "ubuntu" {
  family = var.family
}

resource "yandex_compute_instance" "web" {
  for_each = toset([1,2])
  name = "web-${each.key}"
  platform_id = var.platform_id
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata.ubuntu.serial-port-enable
    ssh-keys           = var.metadata.ubuntu.ssh-key
  }

}
