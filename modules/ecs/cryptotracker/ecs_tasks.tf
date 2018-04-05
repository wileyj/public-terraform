resource "aws_ecs_task_definition" "cryptotracker_elasticsearch" {
  family                = "cryptotracker_elasticsearch"
  container_definitions = "${file("datasources/task-definitions/cryptotracker_elasticsearch.json")}"

  volume {
    name      = "esdata"
    host_path = "/srv/log/elasticsearch"
  }

  depends_on = [
    "aws_cloudwatch_log_group.elasticsearch",
    "aws_alb_listener.cryptotracker_elasticsearch",
  ]
}

resource "aws_ecs_task_definition" "cryptotracker_app" {
  family                = "cryptotracker_app"
  container_definitions = "${file("datasources/task-definitions/cryptotracker_app.json")}"

  depends_on = [
    "aws_ecs_task_definition.cryptotracker_elasticsearch",
  ]
}

resource "aws_ecs_task_definition" "cryptotracker_kibana" {
  family                = "cryptotracker_kibana"
  container_definitions = "${file("datasources/task-definitions/cryptotracker_kibana.json")}"

  depends_on = [
    "aws_ecs_task_definition.cryptotracker_elasticsearch",
  ]
}

resource "aws_cloudwatch_log_group" "elasticsearch" {
  name              = "elasticsearch.${var.domain}"
  retention_in_days = 1

  tags {
    Name        = "elasticsearch.${var.domain}"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region}"
    Application = "shared"
    Role        = "vpc"
    Service     = "cloudwatch"
  }
}
