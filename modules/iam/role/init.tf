resource "aws_iam_role" "default" {
  name               = "${var.role_name}"
  assume_role_policy = "${var.assume_role_policy}"
}
