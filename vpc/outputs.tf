output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}
