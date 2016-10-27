resource "aws_kms_key" "default" {
  description = "${var.description}"

  //deletion_window_in_days = 365
  enable_key_rotation = false
}

resource "aws_kms_alias" "default" {
  name          = "alias/${var.group}/${var.name}"
  target_key_id = "${aws_kms_key.default.key_id}"
}
