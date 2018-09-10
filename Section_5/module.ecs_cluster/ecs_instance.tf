# User data
data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"

  vars {
    ecs_cluster_name = "${var.ecs_cluster_name}"
  }
}

data "template_cloudinit_config" "user_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.user_data.rendered}"
  }
}

resource "aws_launch_configuration" "ecs_cluster_node" {
  count       = "${var.create_container_instances ? 1 : 0}"
  name_prefix = "${var.ecs_cluster_name}-ecs-cluster"

  image_id             = "${data.aws_ami.amazon_linux_ecs_optimised.id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.name}"

  enable_monitoring = false

  security_groups = ["${aws_security_group.ecs_cluster_node.id}"]

  user_data = "${data.template_cloudinit_config.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_cluster_node" {
  count             = "${var.create_container_instances ? 1 : 0}"
  name              = "${aws_launch_configuration.ecs_cluster_node.name}-asg"
  min_size          = 0
  desired_capacity  = 1
  max_size          = 1
  health_check_type = "EC2"

  launch_configuration = "${aws_launch_configuration.ecs_cluster_node.name}"

  vpc_zone_identifier = ["${var.vpc_zone_identifier}"]

  tags = [
    {
      key                 = "Name"
      value               = "${var.ecs_cluster_name} ECS node"
      propagate_at_launch = true
    },
  ]
}
