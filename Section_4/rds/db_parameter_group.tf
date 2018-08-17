resource "aws_db_parameter_group" "default" {
  name   = "${var.db_name}"
  family = "postgres10"

  # Enable logging
  parameter {
    name  = "log_statement"
    value = "all"
  }

  parameter {
    name = "log_min_duration_statement"

    # in milliseconds
    value = "1000"
  }

  tags = {
    "Name" = "Postgres param group for ${var.db_name}"
  }
}
