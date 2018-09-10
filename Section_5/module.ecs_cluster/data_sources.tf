data "template_file" "public_key" {
  template = "${file("~/.ssh/id_rsa.pub")}"
}

# AWS
data "aws_region" "current" {}

data "aws_ami" "amazon_linux_ecs_optimised" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
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
