data "http" "ip" {
  url = "http://icanhazip.com"
}

resource "aws_security_group" "crypto_pricetracker" {
  name        = "${var.org_name}.${var.vpc_name}.crypto_pricetracker"
  description = "${var.vpc_name} crypto_pricetracker traffic"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.org_name}.${var.vpc_name}.crypto_pricetracker"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region}"
    Application = "shared"
    Role        = "networking"
    Service     = "ec2"
    Category    = "security.group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "crypto_pricetracker_external" {
  name        = "${var.org_name}.${var.vpc_name}.crypto_pricetracker.external"
  description = "${var.vpc_name} crypto_pricetracker external traffic"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.org_name}.${var.vpc_name}.crypto_pricetracker_external"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region}"
    Application = "shared"
    Role        = "networking"
    Service     = "ec2"
    Category    = "security.group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_crypto_pricetracker_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.crypto_pricetracker.id}"

  depends_on = [
    "aws_security_group.crypto_pricetracker",
  ]
}

resource "aws_security_group_rule" "allow_crypto_pricetracker_allow_outbound_external" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.crypto_pricetracker_external.id}"

  depends_on = [
    "aws_security_group.crypto_pricetracker_external",
  ]
}

resource "aws_security_group_rule" "allow_crypto_pricetracker_5000" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  security_group_id = "${aws_security_group.crypto_pricetracker.id}"

  cidr_blocks = [
    "${var.cidr}",
  ]

  depends_on = [
    "aws_security_group.crypto_pricetracker",
  ]
}

resource "aws_security_group_rule" "allow_crypto_pricetracker_5000_sg" {
  type                     = "ingress"
  from_port                = 5000
  to_port                  = 5000
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.crypto_pricetracker.id}"
  source_security_group_id = "${aws_security_group.crypto_pricetracker.id}"

  depends_on = [
    "aws_security_group.crypto_pricetracker",
  ]
}

resource "aws_security_group_rule" "allow_crypto_pricetracker_5000_external" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  security_group_id = "${aws_security_group.crypto_pricetracker_external.id}"

  cidr_blocks = [
    "${chomp(data.http.ip.body)}/32",
  ]

  depends_on = [
    "aws_security_group.crypto_pricetracker_external",
  ]
}
