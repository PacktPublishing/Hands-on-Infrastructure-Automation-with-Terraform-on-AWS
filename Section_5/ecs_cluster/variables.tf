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

variable "region" {
  type = "string"
}
