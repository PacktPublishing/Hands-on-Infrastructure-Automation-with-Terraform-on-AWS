data "terraform_remote_state" "rds" {
  backend = "s3"

  config {
    bucket = "packt-terraform-backbone-test-${var.region}"
    key    = "test/rds"
    region = "${var.region}"
  }
}
