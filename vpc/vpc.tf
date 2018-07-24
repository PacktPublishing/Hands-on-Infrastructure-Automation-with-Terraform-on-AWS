resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"

  tags = "${merge(
    data.terraform_remote_state.common.default_tags,
    map("Name", "Main VPC"))}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(
    data.terraform_remote_state.common.default_tags,
    map("Name", "IGF for the main VPC"))}"
}
