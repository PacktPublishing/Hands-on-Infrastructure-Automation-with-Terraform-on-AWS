resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["${data.terraform_remote_state.vpc.private_subnets}"]

  tags = {
    "Name" = "${var.db_name} subnet group"
  }
}
