# variable "sensu_max_size" {
#   default = "0"
# }
#
# variable "sensu_min_size" {
#   default = "0"
# }
#
# variable "sensu_desired_capacity" {
#   default = "0"
# }
#
# resource "aws_autoscaling_group" "sensu" {
#   vpc_zone_identifier       = ["${aws_subnet.private.*.id}"]
#   name                      = "shared-sensu-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}.${var.domain}"
#   max_size                  = "${var.sensu_max_size}"
#   min_size                  = "${var.sensu_min_size}"
#   desired_capacity          = "${var.sensu_desired_capacity}"
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   force_delete              = true
#   launch_configuration      = "${aws_launch_configuration.sensu.*.name}"
#
#   termination_policies = [
#     "OldestLaunchConfiguration",
#     "ClosestToNextInstanceHour",
#   ]
#
#   enabled_metrics = [
#     "GroupMinSize",
#     "GroupMaxSize",
#     "GroupDesiredCapacity",
#     "GroupInServiceInstances",
#     "GroupPendingInstances",
#     "GroupTerminatingInstances",
#     "GroupTotalInstances",
#   ]
#
#   lifecycle {
#     create_before_destroy = true
#   }
#
#   tag {
#     key                 = "Name"
#     value               = "shared.${var.environment}.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.region["${var.buildenv}"]}"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Department"
#     value               = "${var.owner}"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Environment"
#     value               = "${var.environment}"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Stage"
#     value               = "${element(var.ecs_env["${var.buildenv}"], count.index)}"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Application"
#     value               = "shared"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Service"
#     value               = "ec2"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Role"
#     value               = "sensu"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Category"
#     value               = "autoscaling.group"
#     propagate_at_launch = true
#   }
#
#   tag {
#     key                 = "Region"
#     value               = "${var.region["${var.buildenv}"]}"
#     propagate_at_launch = true
#   }
# }

