resource "aws_launch_template" "bastion" {
  name     = "bastion"
  image_id = "${data.aws_ami.amazon_linux.id}"

  instance_type = "t2.micro"

  credit_specification {
    # Can be "standard" or "unlimited".
    cpu_credits = "standard"
  }

  key_name = "${data.terraform_remote_state.common.admin_key_name}"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = ["${aws_security_group.bastion.id}"]
  }

  #   block_device_mappings {
  #     device_name = "/dev/sda1"


  #     ebs {
  #       volume_size = 20
  #     }
  #   }


  #   iam_instance_profile {
  #     name = "test"
  #   }


  #   instance_initiated_shutdown_behavior = "terminate"
  #   instance_market_options {
  #     market_type = "spot"
  #   }

  monitoring {
    enabled = false
  }
  tag_specifications {
    resource_type = "instance"

    tags = "${merge(
        data.terraform_remote_state.common.default_tags,
        map("Name", "Bastion host"))}"
  }
}

resource "aws_autoscaling_group" "bastion" {
  name             = "bastion-asg"
  min_size         = 0
  desired_capacity = 1
  max_size         = 1

  health_check_type = "EC2"

  launch_template = {
    id      = "${aws_launch_template.bastion.id}"
    version = "$$Latest"
  }

  vpc_zone_identifier = ["${aws_subnet.public.*.id}"]

  tags = ["${data.terraform_remote_state.common.default_ec2_tags}"]
}

# Security group
resource "aws_security_group" "bastion" {
  name        = "Bastion SG"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  tags = "${merge(
        data.terraform_remote_state.common.default_tags,
        map("Name", "Bastion SG"))}"
}

resource "aws_security_group_rule" "allow_all_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.bastion.id}"
}
