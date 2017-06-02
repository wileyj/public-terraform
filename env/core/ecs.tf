/* resources defined for completeness; there's potentially no need for a cluster in this VPC though */
/* ecs doesn't support '.' in names yet, so '_' is used here. */

resource "aws_ecs_cluster" "shared" {
    count  = "${length(var.ecs_env["${var.buildenv}"])}"
    /*name = "${element(var.ecs_env["${var.buildenv}"], count.index)}-shared-${var.environment}_${var.region["${var.buildenv}"]}"*/
    name = "${element(var.ecs_env["${var.buildenv}"], count.index)}-shared-${var.environment}"
    lifecycle {
        create_before_destroy = true
    }
}
