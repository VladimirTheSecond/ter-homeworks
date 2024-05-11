###web instance
output "web_instance_name" {
  value       = yandex_compute_instance.platform.name
  description = "web instance name"
}

output "web_external_ip" {
  value       = yandex_compute_instance.platform.network_interface
  description = "web instance network interface"
}

output "web_fqdn" {
  value       = yandex_compute_instance.platform.fqdn
  description = "web instance network interface"
}

###db instance
output "db_instance_name" {
  value       = yandex_compute_instance.platform-db.name
  description = "db instance name"
}

output "db_external_ip" {
  value       = yandex_compute_instance.platform-db.network_interface
  description = "db instance network interface"
}

output "db_fqdn" {
  value       = yandex_compute_instance.platform-db.fqdn
  description = "db instance network interface"
}