resource "aws_ecs_service" "cryptotracker_elasticsearch" {
  name                               = "cryptotracker_elasticsearch"
  cluster                            = "${var.ecs_cluster}"
  task_definition                    = "${aws_ecs_task_definition.cryptotracker_elasticsearch.arn}"
  desired_count                      = 3
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
  iam_role                           = "${var.ecs_base_role}"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.cryptotracker_elasticsearch.arn}"
    container_name   = "cryptotracker_elasticsearch"
    container_port   = "9200"
  }

  depends_on = [
    "aws_ecs_task_definition.cryptotracker_elasticsearch",
  ]
}

resource "aws_ecs_service" "cryptotracker_app" {
  name                               = "cryptotracker_app"
  cluster                            = "${var.ecs_cluster}"
  task_definition                    = "${aws_ecs_task_definition.cryptotracker_app.arn}"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100

  placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  depends_on = [
    "aws_ecs_service.cryptotracker_elasticsearch",
    "aws_ecs_task_definition.cryptotracker_app",
    "aws_alb_target_group.cryptotracker_elasticsearch",
  ]
}

resource "aws_ecs_service" "cryptotracker_kibana" {
  name                               = "cryptotracker_kibana"
  cluster                            = "${var.ecs_cluster}"
  task_definition                    = "${aws_ecs_task_definition.cryptotracker_kibana.arn}"
  desired_count                      = 3
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
  iam_role                           = "${var.ecs_base_role}"

  placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.cryptotracker_kibana.arn}"
    container_name   = "cryptotracker_kibana"
    container_port   = "5601"
  }

  depends_on = [
    "aws_ecs_service.cryptotracker_elasticsearch",
    "aws_ecs_task_definition.cryptotracker_kibana",
    "aws_alb_target_group.cryptotracker_kibana",
  ]
}
