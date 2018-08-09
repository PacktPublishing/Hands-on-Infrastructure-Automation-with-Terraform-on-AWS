provider "aws" {
  region = "${var.s3_region}"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "packt-terraform-backbone-test-ap-southeast-2"

    key = "test/backbone"

    region = "ap-southeast-2"

    encrypt = "true"
  }
}
