provider "aws" {
  region  = "${var.region}"
  version = "1.31"
}

provider "random" {
  version = "1.3"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "packt-terraform-backbone-test-ap-southeast-2"

    key = "test/rds"

    region = "ap-southeast-2"

    encrypt = "true"
  }
}
