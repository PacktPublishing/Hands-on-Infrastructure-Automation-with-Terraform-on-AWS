output "cluster_id" {
  value = "${module.ecs_cluster.cluster_id}"
}

output "ecs_instance_iam_role_arn" {
  value = "${module.ecs_cluster.ecs_instance_iam_role_arn}"
}

output "security_group_id" {
  value = "${module.ecs_cluster.security_group_id}"
}
