variable "region" {
  type = "string"
}

variable "app_image_repository" {
  type = "string"
}

variable "app_image_version" {
  type = "string"
}

variable "app_name" {
  type = "string"
}

variable "cpu" {
  type = "string"
}

variable "memory" {
  type = "string"
}

variable "container_port" {
  type = "string"
}

variable "desired_count" {
  type = "string"
}

variable "pgsslmode" {
  type = "string"
}

variable "network_mode" {
  type = "string"
}

variable "requires_compatibilities" {
  type = "list"
}

variable "launch_type" {
  type = "string"
}

variable "health_check_path" {
  type = "string"
}

variable "container_definitions" {
  type = "string"
}
