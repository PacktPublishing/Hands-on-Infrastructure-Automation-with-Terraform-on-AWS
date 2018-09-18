module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.40.0"

  name = "${local.name}"
  cidr = "${var.cidr}"

  azs            = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  intra_subnets  = "${var.intra_subnets["${terraform.workspace}"]}"
  public_subnets = "${var.public_subnets["${terraform.workspace}"]}"

  tags = {
    Environment = "${terraform.workspace}"
  }
}
