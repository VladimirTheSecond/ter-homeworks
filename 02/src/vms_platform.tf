variable "vm_db_name" {
  type        = string
  default     = "platform-db"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "database_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}