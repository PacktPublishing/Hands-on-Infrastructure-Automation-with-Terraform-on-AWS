provider "aws" {
  region  = "${var.s3_region}"
  profile = "terraform-test"
  version = "1.37"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "packt-terraform-backbone-test-ap-southeast-2"

    key = "test/backbone"

    region  = "ap-southeast-2"
    profile = "terraform-test"
    encrypt = "true"
  }
}
