provider "aws" {
  region  = "${var.region}"
  version = "~> 1.28"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket  = "packt-terraform-backbone-test-ap-southeast-2"
    key     = "state/common"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}
