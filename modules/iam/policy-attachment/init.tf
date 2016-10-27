resource "aws_iam_policy" "default" {
  name = "${var.policy_name}"
  path = "${var.path}"
  policy = "${var.policy}"
}
