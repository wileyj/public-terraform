data "template_file" "crypto_pricetracker_environment" {
  template = "${file("modules/ecs/crypto_pricetracker/task-definitions/crypto_pricetracker_environment.json")}"
}

data "template_file" "crypto_pricetracker" {
  template = "${file("modules/ecs/crypto_pricetracker/task-definitions/crypto_pricetracker.json")}"

  vars {
    environment          = "${data.template_file.crypto_pricetracker_environment.rendered}"
    nodejs_docker_image  = "${var.nodejs_docker_image}"
    nodejs_mem           = "${var.nodejs_mem}"
    nodejs_cpu           = "${var.nodejs_cpu}"
    nodejs_port          = "${var.nodejs_port}"
    redis_docker_image   = "${var.redis_docker_image}"
    redis_mem            = "${var.redis_mem}"
    redis_cpu            = "${var.redis_cpu}"
    redis_source_volume  = "${var.redis_source_volume}"
    redis_container_path = "${var.redis_source_volume}"
  }
}

resource "aws_ecs_task_definition" "crypto_pricetracker" {
  family                = "crypto_pricetracker"
  container_definitions = "${data.template_file.crypto_pricetracker.rendered}"

  volume {
    name      = "redisdata"
    host_path = "/srv/log/redis"
  }

  depends_on = [
    "aws_cloudwatch_log_group.crypto_pricetracker",
    "aws_alb_listener.crypto_pricetracker",
  ]
}

resource "aws_cloudwatch_log_group" "crypto_pricetracker" {
  name              = "crypto_pricetracker.${var.domain}"
  retention_in_days = 1

  tags {
    Name        = "crypto_pricetracker.${var.domain}"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region}"
    Application = "shared"
    Role        = "vpc"
    Service     = "cloudwatch"
  }
}
