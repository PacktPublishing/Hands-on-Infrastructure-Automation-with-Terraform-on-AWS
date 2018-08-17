resource "aws_db_instance" "default" {
  identifier           = "${var.db_name}"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.4"
  instance_class       = "${var.instance_class}"
  name                 = "${var.db_name}"
  username             = "${var.username}"
  password             = "${random_string.db_password.result}"
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  parameter_group_name = "${aws_db_parameter_group.default.id}"
  publicly_accessible  = false
  skip_final_snapshot  = true

  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags = {
    "Name" = "${var.db_name}"
  }
}
