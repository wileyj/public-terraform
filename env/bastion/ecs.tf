/*resource "aws_ecs_cluster" "shared" {
    count  = "${length(var.ecs_env["${var.buildenv}"])}"
    name = "${element(var.ecs_env["${var.buildenv}"], count.index)}-shared-${var.environment}"
    lifecycle {
        create_before_destroy = true
    }
}*/

