resource "aws_security_group" "default" {
  name        = "${var.org_name}.${var.name}.Internal"
  description = "${var.name} internal traffic"
  vpc_id      = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.org_name}.${var.name}.internal"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region["${var.buildenv}"]}"
    Application = "shared"
    Role        = "networking"
    Service     = "ec2"
    Category    = "security.group"
  }

  lifecycle {
    create_before_destroy = true

    /*prevent_destroy = true*/
  }
}

resource "aws_security_group_rule" "allow_sg_tcp" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.default.id}"
  security_group_id        = "${aws_security_group.default.id}"

  depends_on = [
    "aws_security_group.default",
  ]
}

resource "aws_security_group_rule" "allow_sg_udp" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.default.id}"
  security_group_id        = "${aws_security_group.default.id}"

  depends_on = [
    "aws_security_group.default",
  ]
}

resource "aws_security_group_rule" "allow_vpc_tcp" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  cidr_blocks = [
    "${lookup(var.cidr, var.region["${var.buildenv}"])}",
  ]

  security_group_id = "${aws_security_group.default.id}"

  depends_on = [
    "aws_security_group.default",
  ]
}

resource "aws_security_group_rule" "allow_bastion_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = [
    "${lookup(var.cidr, var.region["${var.buildenv}"])}",
  ]

  security_group_id = "${aws_security_group.default.id}"

  depends_on = [
    "aws_security_group.default",
  ]
}

resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.default.id}"

  depends_on = [
    "aws_security_group.default",
  ]
}
