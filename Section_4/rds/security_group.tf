# Security group
resource "aws_security_group" "default" {
  name        = "${var.db_name} db SG"
  description = "Allow Postgres traffic"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = {
    "Name" = "${var.db_name} db SG"
  }
}

resource "aws_security_group_rule" "allow_ingress" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["${concat(data.terraform_remote_state.vpc.public_cidrs, data.terraform_remote_state.vpc.private_cidrs)}"]

  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "allow_egress" {
  type        = "egress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["${concat(data.terraform_remote_state.vpc.public_cidrs, data.terraform_remote_state.vpc.private_cidrs)}"]

  security_group_id = "${aws_security_group.default.id}"
}
