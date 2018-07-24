output "default_tags" {
  value = {
    environment = "${var.environment}"
    created_by  = "terraform"
    team        = "devops"
  }
}

output "default_ec2_tags" {
  value = [
    {
      key                 = "environment"
      value               = "${var.environment}"
      propagate_at_launch = true
    },
    {
      key                 = "created_by"
      value               = "terraform"
      propagate_at_launch = true
    },
    {
      key                 = "team"
      value               = "devops"
      propagate_at_launch = true
    },
  ]
}

# output "public_key" {
#   value = "${data.template_file.public_key.rendered}"
# }

output "admin_key_name" {
  value = "${aws_key_pair.admin.key_name}"
}
