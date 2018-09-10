module "child" {
  source = "../module.ecs_app_web"

  region = "${var.region}"

  app_image_version = "${var.app_image_version}"

  app_image_repository = "${var.app_image_repository}"

  app_name = "${var.app_name}"

  cpu = "${var.cpu}"

  memory = "${var.memory}"

  container_port = "${var.container_port}"

  desired_count = "${var.desired_count}"

  network_mode = "${var.network_mode}"

  requires_compatibilities = "${var.requires_compatibilities}"

  launch_type = "${var.launch_type}"

  pgsslmode = "${var.pgsslmode}"

  health_check_path = "${var.health_check_path}"

  container_definitions = "${data.template_file.todo_app.rendered}"
}
