module "ecs_cluster" {
  source = "../module.ecs_cluster"

  create_container_instances = "true"
  instance_type              = "${var.instance_type}"
  security_group_cidr_blocks = ["${concat(data.terraform_remote_state.vpc.public_cidrs, data.terraform_remote_state.vpc.private_cidrs)}"]
  vpc_id                     = "${data.terraform_remote_state.vpc.vpc_id}"
  vpc_zone_identifier        = ["${data.terraform_remote_state.vpc.private_subnets}"]
}

resource "aws_security_group_rule" "allow_ping" {
  count             = "${var.create_container_instances ? 1 : 0}"
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.ecs_cluster.security_group_id}"
}
