variable "environment" {
  type    = "string"
  default = "test"
}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "bastion_instance_type" {
  type = "string"
}

variable "cidr_block" {
  type        = "string"
  description = "VPC cidr block. Example: 10.0.0.0/16"
}
