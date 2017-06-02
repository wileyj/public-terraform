resource "aws_iam_policy" "default" {
    name   = "${var.policy_name}"
    path   = "${var.path}"
    policy = "${var.policy}"
    lifecycle {
        create_before_destroy = true
        prevent_destroy = true
    }
}
