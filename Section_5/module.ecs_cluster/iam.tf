data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_instance" {
  statement {
    actions = [
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_role" "ecs_instance" {
  count              = "${var.create_container_instances ? 1 : 0}"
  assume_role_policy = "${data.aws_iam_policy_document.trust.json}"
  name               = "ecs-agent-${var.ecs_cluster_name}-${data.aws_region.current.name}"
}

resource "aws_iam_policy" "ecs_instance" {
  count       = "${var.create_container_instances ? 1 : 0}"
  name        = "ecs-agent-${var.ecs_cluster_name}-${data.aws_region.current.name}"
  path        = "/"
  description = "ECS agent policy for ${var.ecs_cluster_name} cluster in ${data.aws_region.current.name}"

  policy = "${data.aws_iam_policy_document.ecs_instance.json}"
}

resource "aws_iam_role_policy_attachment" "ecs_instance" {
  count      = "${var.create_container_instances ? 1 : 0}"
  role       = "${aws_iam_role.ecs_instance.name}"
  policy_arn = "${aws_iam_policy.ecs_instance.arn}"
}

resource "aws_iam_instance_profile" "ecs_instance" {
  count = "${var.create_container_instances ? 1 : 0}"
  name  = "ecs-agent-${var.ecs_cluster_name}-${data.aws_region.current.name}"
  path  = "/"
  role  = "${aws_iam_role.ecs_instance.name}"
}
