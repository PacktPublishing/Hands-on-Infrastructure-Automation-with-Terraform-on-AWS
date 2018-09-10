resource "aws_cloudwatch_log_group" "todo_app" {
  name = "${var.app_name}"

  retention_in_days = 1
}
