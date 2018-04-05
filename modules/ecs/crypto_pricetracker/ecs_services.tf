resource "aws_ecs_service" "crypto_pricetracker" {
  name                               = "crypto_pricetracker"
  cluster                            = "${var.ecs_cluster}"
  task_definition                    = "${aws_ecs_task_definition.crypto_pricetracker.arn}"
  desired_count                      = 3
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
  iam_role                           = "${var.ecs_base_role}"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = "${aws_alb_target_group.crypto_pricetracker.arn}"
    container_name   = "crypto_pricetracker_nodejs"
    container_port   = "5000"
  }

  depends_on = [
    "aws_ecs_task_definition.crypto_pricetracker",
    "aws_alb_target_group.crypto_pricetracker",
  ]
}
