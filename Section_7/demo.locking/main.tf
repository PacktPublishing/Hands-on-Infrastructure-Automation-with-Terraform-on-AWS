provider "aws" {
  region  = "ap-southeast-2"
  profile = "terraform-test"

  version = "1.31"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket  = "packt-terraform-backbone-test-ap-southeast-2"
    key     = "vpc"
    region  = "ap-southeast-2"
    encrypt = "true"
    profile = "terraform-test"

    dynamodb_table = "terraform-lock-table"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Main VPC 2"
  }
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
