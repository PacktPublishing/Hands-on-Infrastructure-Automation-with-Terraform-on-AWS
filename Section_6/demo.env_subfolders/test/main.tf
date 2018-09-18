module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.41.0"

  name = "${var.environment}-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  tags = {
    Environment = "${var.environment}"
  }
}
