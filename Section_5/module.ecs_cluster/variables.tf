variable "create_container_instances" {
  type    = "string"
  default = "false"
}

variable "ecs_cluster_name" {
  type    = "string"
  default = "main"
}

variable "instance_type" {
  type = "string"
}

variable "security_group_cidr_blocks" {
  type = "list"
}

variable "vpc_id" {
  type = "string"
}

variable "vpc_zone_identifier" {
  type = "list"
}
