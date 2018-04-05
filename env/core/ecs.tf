/* resources defined for completeness; there's potentially no need for a cluster in this VPC though */
/* ecs doesn't support '.' in names yet, so '_' is used here. */

resource "aws_ecs_cluster" "shared" {
  count = "${length(var.ecs_env["${var.buildenv}"])}"

  /*name = "${element(var.ecs_env["${var.buildenv}"], count.index)}-shared-${var.environment}_${var.region["${var.buildenv}"]}"*/
  name = "${element(var.ecs_env["${var.buildenv}"], count.index)}-shared-${var.environment}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecr_repository" "default" {
  name = "${var.name_lower}.${var.domain}"
}

resource "aws_route_table" "ecs" {
  count  = "${length(split(",", lookup(var.ecs_subnets, var.region["${var.buildenv}"])))}"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.org_name}.${var.name}.ecs.${element(var.azones["${var.buildenv}"], count.index)}"
    VPC         = "${var.name}"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region["${var.buildenv}"]}"
    Application = "shared"
    Role        = "networking"
    Service     = "vpc"
    Category    = "route.table"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_nat_gateway.default",
    "aws_vpc.default",
  ]
}

resource "aws_route" "ecs" {
  count                  = "${length(split(",", lookup(var.ecs_subnets, var.region["${var.buildenv}"])))}"
  route_table_id         = "${element(aws_route_table.ecs.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.default.*.id, count.index)}"

  depends_on = [
    "aws_route_table.ecs",
  ]
}

resource "aws_route_table_association" "ecs" {
  count          = "${length(split(",", lookup(var.ecs_subnets, var.region["${var.buildenv}"])))}"
  subnet_id      = "${element(aws_subnet.ecs.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.ecs.*.id, count.index)}"

  depends_on = [
    "aws_subnet.ecs",
    "aws_route.ecs",
  ]
}

resource "aws_subnet" "ecs" {
  count                   = "${length(split(",", lookup(var.ecs_subnets, var.region["${var.buildenv}"])))}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${element(split(",", lookup(var.ecs_subnets, var.region["${var.buildenv}"])), count.index)}"
  availability_zone       = "${element(var.azones["${var.buildenv}"], count.index)}"
  map_public_ip_on_launch = "false"

  tags {
    Name        = "${var.org_name}.${var.name}.ecs.${element(var.azones["${var.buildenv}"], count.index)}"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region["${var.buildenv}"]}"
    Application = "shared"
    Role        = "networking"
    Service     = "vpc"
    Category    = "subnet"
  }

  lifecycle {
    create_before_destroy = true

    /*prevent_destroy = true*/
  }

  depends_on = [
    "aws_vpc.default",
  ]
}

resource "aws_security_group" "ecs" {
  name        = "${var.org_name}.${var.name}.ECS"
  description = "${var.name} ecs traffic"
  vpc_id      = "${aws_vpc.default.id}"

  tags {
    Name        = "${var.org_name}.${var.name}.ecs"
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
  }
}

resource "aws_security_group_rule" "allow_vpc_tcp_ecs" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  cidr_blocks = [
    "${lookup(var.cidr, var.region["${var.buildenv}"])}",
  ]

  security_group_id = "${aws_security_group.ecs.id}"

  depends_on = [
    "aws_security_group.ecs",
  ]
}

resource "aws_security_group_rule" "allow_bastion_ssh_ecs" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = [
    "${var.bastion_cidr}",
  ]

  security_group_id = "${aws_security_group.ecs.id}"

  depends_on = [
    "aws_security_group.ecs",
  ]
}

resource "aws_security_group_rule" "allow_outbound_ecs" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ecs.id}"

  depends_on = [
    "aws_security_group.ecs",
  ]
}
