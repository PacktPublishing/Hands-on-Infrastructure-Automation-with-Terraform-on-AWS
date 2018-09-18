provider "aws" {
  region  = "${var.region}"
  profile = "terraform-${var.environment}"
  version = "1.35"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    profile = "terraform-test"
    bucket  = "packt-terraform-backbone-test-ap-southeast-2"
    key     = "vpc/test.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}
