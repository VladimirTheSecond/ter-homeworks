###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "netology"
  description = "VPC network & subnet name"
}

###VM specific vars
variable "family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type        = string
  default     = "platform-web"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "vms_resources" {
  description = "Map of resourses"
  type        = map(object({
    cores         = optional(number)
    memory        = optional(number)
    core_fraction = optional(number)
  }))
  
  default = {
  web = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

###metadata
  variable "vms_metadata" {
    description = "metadata for virtual machines - serial port flag, ssh-key"
    type        = map(object({
      serial-port-enable = optional(number)
      ssh-keys           = optional(string)
    }))

    default = {
      ubuntu = {
      serial-port-enable = 1
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5jVTBmdxuviDkv7gY/BKNaSRIAmXmgUxHjqKIuT8mh vladimir@vladimir-desktop"
      }
    }
  }