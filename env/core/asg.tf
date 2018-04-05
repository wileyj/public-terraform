variable "ecs_max_size" {
  default = "3"
}

variable "ecs_min_size" {
  default = "3"
}

variable "ecs_desired_capacity" {
  default = "3"
}

resource "aws_autoscaling_group" "ecs" {
  count = "${length(var.ecs_env["${var.buildenv}"])}"

  # vpc_zone_identifier       = ["${aws_subnet.private.0.id}"]
  vpc_zone_identifier       = ["${aws_subnet.ecs.*.id}"]
  name                      = "shared-ecs-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}.${var.domain}"
  max_size                  = "${var.ecs_max_size}"
  min_size                  = "${var.ecs_min_size}"
  desired_capacity          = "${var.ecs_desired_capacity}"
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  default_cooldown          = 300
  launch_configuration      = "${element(aws_launch_configuration.ecs.*.name, count.index)}"

  termination_policies = [
    "OldestLaunchConfiguration",
    "ClosestToNextInstanceHour",
  ]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "shared-ecs-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}.${var.domain}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Department"
    value               = "${var.owner}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Stage"
    value               = "${element(var.ecs_env["${var.buildenv}"], count.index)}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Application"
    value               = "shared"
    propagate_at_launch = true
  }

  tag {
    key                 = "Service"
    value               = "ec2"
    propagate_at_launch = true
  }

  tag {
    key                 = "Role"
    value               = "ecs"
    propagate_at_launch = true
  }

  tag {
    key                 = "Category"
    value               = "autoscaling.group"
    propagate_at_launch = true
  }

  tag {
    key                 = "Region"
    value               = "${var.region["${var.buildenv}"]}"
    propagate_at_launch = true
  }

  tag {
    key                 = "ElasticSearch"
    value               = "esnode"
    propagate_at_launch = true
  }

  depends_on = [
    "aws_launch_configuration.ecs",
  ]
}
