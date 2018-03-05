variable "resource_group_name" {}

variable "resource_group_location" {}

variable "subnet_id" {}

variable "network_security_group_id" {}

variable "environment" {
  description = "Name of the environment the VM will be deployed in"
  default     = "dev"
}