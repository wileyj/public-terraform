data "http" "ip" {
  url = "http://icanhazip.com"
}

resource "aws_security_group" "cryptotracker" {
  name        = "${var.org_name}.${var.vpc_name}.cryptotracker"
  description = "${var.vpc_name} cryptotracker traffic"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.org_name}.${var.vpc_name}.cryptotracker"
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

resource "aws_security_group" "cryptotracker_external" {
  name        = "${var.org_name}.${var.vpc_name}.cryptotracker.external"
  description = "${var.vpc_name} cryptotracker external traffic"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.org_name}.${var.vpc_name}.cryptotracker"
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

resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cryptotracker.id}"

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_outbound_external" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cryptotracker_external.id}"

  depends_on = [
    "aws_security_group.cryptotracker_external",
  ]
}

resource "aws_security_group_rule" "allow_elasticsearch_9200" {
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker.id}"

  cidr_blocks = [
    "${var.cidr}",
  ]

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_elasticsearch_9200_sg" {
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker.id}"

  source_security_group_id = "${aws_security_group.cryptotracker.id}"

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_elasticsearch_9300" {
  type              = "ingress"
  from_port         = 9300
  to_port           = 9300
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker.id}"

  cidr_blocks = [
    "${var.cidr}",
  ]

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_elasticsearch_9300_sg" {
  type                     = "ingress"
  from_port                = 9300
  to_port                  = 9300
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.cryptotracker.id}"
  source_security_group_id = "${aws_security_group.cryptotracker.id}"

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_kibana_5601" {
  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker.id}"

  cidr_blocks = [
    "${var.cidr}",
  ]

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}

resource "aws_security_group_rule" "allow_kibana_external_5601" {
  type              = "ingress"
  from_port         = 5601
  to_port           = 5601
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker_external.id}"

  cidr_blocks = [
    "${chomp(data.http.ip.body)}/32",
  ]

  depends_on = [
    "aws_security_group.cryptotracker_external",
  ]
}

resource "aws_security_group_rule" "allow_elasticsearch_external_9200" {
  type              = "ingress"
  from_port         = 9200
  to_port           = 9200
  protocol          = "tcp"
  security_group_id = "${aws_security_group.cryptotracker_external.id}"

  cidr_blocks = [
    "${chomp(data.http.ip.body)}/32",
  ]

  depends_on = [
    "aws_security_group.cryptotracker_external",
  ]
}

resource "aws_security_group_rule" "allow_kibana_5601_sg" {
  type                     = "ingress"
  from_port                = 5601
  to_port                  = 5601
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.cryptotracker.id}"
  source_security_group_id = "${aws_security_group.cryptotracker.id}"

  depends_on = [
    "aws_security_group.cryptotracker",
  ]
}
