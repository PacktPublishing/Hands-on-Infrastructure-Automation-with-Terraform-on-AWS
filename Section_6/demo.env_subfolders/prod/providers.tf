provider "aws" {
  region  = "${var.region}"
  profile = "terraform-${var.environment}"
  version = "1.31"
}

terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
  }
}
