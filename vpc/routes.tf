resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(
    data.terraform_remote_state.common.default_tags,
    map("Name", "Main route table"))}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"

  # timeouts {
  #   create = "5m"
  # }
}
