data "yandex_compute_image" "ubuntu" {
  family = var.family
}

###vm_web
resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vm_web_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "platform" {
  name        = local.local_vm_web_name
  platform_id = var.vm_web_platform_id
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
    serial-port-enable = var.vms_metadata.ubuntu.serial-port-enable
    ssh-keys           = var.vms_metadata.ubuntu.ssh-keys
  }

}
###vm_db
resource "yandex_vpc_subnet" "platform-db" {
  name           = var.vm_db_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.database_cidr
}

resource "yandex_compute_instance" "platform-db" {
  name        = local.local_vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
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
    subnet_id = yandex_vpc_subnet.platform-db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_metadata.ubuntu.serial-port-enable
    ssh-keys           = var.vms_metadata.ubuntu.ssh-keys
  }

}