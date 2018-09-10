resource "aws_iam_role" "todo_app" {
  name = "${var.app_name}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "todo_app" {
  name = "${var.app_name}-put-logs"
  role = "${aws_iam_role.todo_app.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
