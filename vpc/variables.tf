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

variable "cidr_block" {
  type = "string"
}

# variable "map_public_ip_on_launch" {
#   type = "string"
# }

