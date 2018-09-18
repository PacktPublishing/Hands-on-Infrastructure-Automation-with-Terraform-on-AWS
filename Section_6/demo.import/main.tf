module "vpc" {
  source = "./module"
}

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
  }
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
