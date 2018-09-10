output "cluster_id" {
  value = "${aws_ecs_cluster.main.id}"
}

output "ami_id" {
  value = "${data.aws_ami.amazon_linux_ecs_optimised.id}"
}

output "ecs_instance_iam_role_arn" {
  value = "${join("", aws_iam_role.ecs_instance.*.arn)}"
}

output "security_group_id" {
  value = "${join("", aws_security_group.ecs_cluster_node.*.id)}"
}
