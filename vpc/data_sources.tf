# Remote state
data "terraform_remote_state" "common" {
  backend = "s3"

  config {
    bucket = "packt-terraform-backbone-test-ap-southeast-2"
    key    = "state/common"
    region = "ap-southeast-2"
  }
}

# AWS
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
