output "web_instance" {
  value       = [yandex_compute_instance.platform.name, yandex_compute_instance.platform.network_interface[0].nat_ip_address, yandex_compute_instance.platform.fqdn]
  description = "web instance instance_name, external_ip, fqdn"
}

output "db_instance" {
  value       = [yandex_compute_instance.platform-db.name, yandex_compute_instance.platform-db.network_interface[0].nat_ip_address, yandex_compute_instance.platform-db.fqdn]
  description = "db instance instance_name, external_ip, fqdn"
}
