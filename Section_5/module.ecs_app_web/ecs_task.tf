# Task

resource "aws_ecs_task_definition" "todo_app" {
  family                   = "${var.app_name}"
  container_definitions    = "${var.container_definitions}"
  requires_compatibilities = "${var.requires_compatibilities}"
  network_mode             = "${var.network_mode}"
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  execution_role_arn       = "${aws_iam_role.todo_app.arn}"
}

# Service
resource "aws_ecs_service" "todo_app" {
  name                               = "${var.app_name}"
  cluster                            = "${data.terraform_remote_state.ecs_cluster.cluster_id}"
  task_definition                    = "${aws_ecs_task_definition.todo_app.arn}"
  desired_count                      = "${var.desired_count}"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "${var.launch_type}"

  # Have to set an explicit dependency here to avoid
  # race condition with LB creation
  depends_on = ["aws_lb_listener.todo_app"]

  load_balancer {
    target_group_arn = "${aws_lb_target_group.todo_app.id}"
    container_name   = "${var.app_name}"
    container_port   = "3000"
  }

  network_configuration {
    security_groups = ["${aws_security_group.ecs_service.id}"]
    subnets         = ["${data.terraform_remote_state.vpc.private_subnets}"]
  }
}

# Security group
resource "aws_security_group" "ecs_service" {
  name        = "${var.app_name}-ecs-sg"
  description = "Controls access to the ${var.app_name} service"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_from_lb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.ecs_service.id}"
  source_security_group_id = "${aws_security_group.lb.id}"
}

resource "aws_security_group_rule" "allow_all_outbound_ecs" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.ecs_service.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
