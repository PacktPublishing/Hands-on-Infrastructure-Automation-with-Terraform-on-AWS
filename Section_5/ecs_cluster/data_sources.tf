data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = "packt-terraform-backbone-test-${var.region}"
    key    = "test/vpc"
    region = "${var.region}"
  }
}
