region = "ap-southeast-2"

app_image_version = "v0.1"

app_image_repository = "endofcake/go-todo-rest-api-example"

app_name = "todo"

cpu = 256

memory = 512

container_port = 3000

desired_count = 3

network_mode = "awsvpc"

requires_compatibilities = ["FARGATE"]

launch_type = "FARGATE"

pgsslmode = "disable"

health_check_path = "/projects"
