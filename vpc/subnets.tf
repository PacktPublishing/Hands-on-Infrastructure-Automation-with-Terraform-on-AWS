################
# Public subnet
################
resource "aws_subnet" "public" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 8, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = "${merge(
    data.terraform_remote_state.common.default_tags,
    map("Name", "Public subnet - ${count.index}"))}"
}

################
# Private subnet
#################
# resource "aws_subnet" "private" {
#   count = "${var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0}"
#   vpc_id            = "${aws_vpc.this.id}"
#   cidr_block        = "${var.private_subnets[count.index]}"
#   availability_zone = "${element(var.azs, count.index)}"
#   tags = "${merge(map("Name", format("%s-private-%s", var.name, element(var.azs, count.index))), var.private_subnet_tags, var.tags)}"
# }

