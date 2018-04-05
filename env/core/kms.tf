resource "aws_kms_key" "default" {
  description         = "VPC/${var.name} KMS asset"
  enable_key_rotation = false

  lifecycle {
    create_before_destroy = true

    # prevent_destroy = true
  }

  tags {
    Name        = "${var.org_name}/${var.name}/default"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region["${var.buildenv}"]}"
    Application = "shared"
    Role        = "security"
    Service     = "iam"
    Category    = "kms"
  }
}

resource "aws_kms_alias" "default" {
  name          = "alias/${var.org_name}/${var.name}/default"
  target_key_id = "${aws_kms_key.default.key_id}"

  lifecycle {
    create_before_destroy = true

    # prevent_destroy = true
  }
}
