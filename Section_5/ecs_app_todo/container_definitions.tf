data "template_file" "todo_app" {
  template = "${file("./templates/ecs_task.tpl")}"

  vars {
    app_name             = "${var.app_name}"
    app_image_repository = "${var.app_image_repository}"
    app_image_version    = "${var.app_image_version}"
    container_port       = "${var.container_port}"
    pghost               = "${data.terraform_remote_state.rds.pghost}"
    pgdatabase           = "${data.terraform_remote_state.rds.pgdatabase}"
    pguser               = "${data.terraform_remote_state.rds.pguser}"
    pgpassword           = "${data.terraform_remote_state.rds.pgpassword}"
    pgsslmode            = "${var.pgsslmode}"
    region               = "${var.region}"
  }
}
