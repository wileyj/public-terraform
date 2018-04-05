resource "aws_eip" "default" {
  count = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  vpc   = true

  lifecycle {
    create_before_destroy = true

    /*prevent_destroy = true*/
  }
}

resource "aws_nat_gateway" "default" {
  count         = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  allocation_id = "${element(aws_eip.default.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true

    /*prevent_destroy = true*/
  }

  depends_on = [
    "aws_internet_gateway.default",
    "aws_eip.default",
    "aws_subnet.public",
  ]
}

resource "aws_route_table" "private" {
  count  = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  vpc_id = "${aws_vpc.default.id}"

  /*route {
                                                                                                                cidr_block = "0.0.0.0/0"
                                                                                                                gateway_id = "${element(aws_nat_gateway.default.*.id, count.index)}"
                                                                                                            }*/
  tags {
    Name        = "${var.org_name}.${var.name}.private.${element(var.azones["${var.buildenv}"], count.index)}"
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

    /*prevent_destroy = true*/
  }

  depends_on = [
    "aws_nat_gateway.default",
    "aws_route_table.private",
  ]
}

resource "aws_route" "private" {
  count                  = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.default.*.id, count.index)}"

  depends_on = [
    "aws_route_table.private",
  ]
}

resource "aws_route_table_association" "private" {
  count          = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"

  depends_on = [
    "aws_route_table.private",
  ]
}

resource "aws_subnet" "private" {
  count                   = "${length(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])))}"
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${element(split(",", lookup(var.private_subnets, var.region["${var.buildenv}"])), count.index)}"
  availability_zone       = "${element(var.azones["${var.buildenv}"], count.index)}"
  map_public_ip_on_launch = "false"

  tags {
    Name        = "${var.org_name}.${var.name}.private.${element(var.azones["${var.buildenv}"], count.index)}"
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
    "aws_route_table.private",
    "aws_vpc.default",
  ]
}
