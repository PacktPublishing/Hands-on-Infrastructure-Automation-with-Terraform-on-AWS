output "pghost" {
  value = "${aws_db_instance.default.address}"
}

output "pguser" {
  value = "${aws_db_instance.default.username}"
}

output "pgpassword" {
  value = "${random_string.db_password.result}"
}

output "pgdatabase" {
  value = "${aws_db_instance.default.name}"
}
