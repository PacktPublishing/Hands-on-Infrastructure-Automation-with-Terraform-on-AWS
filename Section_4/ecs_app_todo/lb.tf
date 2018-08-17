resource "aws_lb" "todo_app" {
  name     = "${var.app_name}-alb"
  internal = false

  security_groups = ["${aws_security_group.lb.id}"]
  subnets         = ["${data.terraform_remote_state.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "todo_app" {
  name_prefix = "todo-"

  protocol    = "HTTP"
  port        = "80"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"
  target_type = "ip"

  health_check {
    path = "/projects"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "todo_app" {
  load_balancer_arn = "${aws_lb.todo_app.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.todo_app.arn}"
    type             = "forward"
  }
}

# Security group
resource "aws_security_group" "lb" {
  name        = "${var.app_name}-lb-sg"
  description = "Controls access to the ${var.app_name} ALB"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_all_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lb.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lb.id}"
}
