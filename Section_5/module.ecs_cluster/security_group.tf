resource "aws_security_group" "ecs_cluster_node" {
  count       = "${var.create_container_instances ? 1 : 0}"
  name_prefix = "${var.ecs_cluster_name} ECS cluster SG"
  description = "${var.ecs_cluster_name} ECS cluster SG"
  vpc_id      = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_outbound" {
  count             = "${var.create_container_instances ? 1 : 0}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs_cluster_node.*.id[0]}"
}
