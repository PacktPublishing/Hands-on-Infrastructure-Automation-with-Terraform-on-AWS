locals {
  name = "${terraform.workspace}-workspace"
}

variable "cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "region" {
  type = "map"

  default = {
    prod = "ap-southeast-2"
    test = "ap-southeast-2"
  }
}

variable "public_subnets" {
  type = "map"

  default = {
    prod = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    test = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  }
}

variable "intra_subnets" {
  type = "map"

  default = {
    prod = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
    test = []
  }
}
