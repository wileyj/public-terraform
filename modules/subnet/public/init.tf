resource "aws_internet_gateway" "default" {
  vpc_id = "${var.id}"

  tags {
    Name   = "${var.name} IGW"
    VPC    = "${var.name}"
    Region = "${var.region["${var.buildenv}"]}"
    Owner  = "${var.owner}"
  }
}

resource "aws_route_table" "default" {
  count  = "${length(split(",",var.subnets))}"
  vpc_id = "${var.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_internet_gateway.default.*.id, count.index)}"
  }

  tags {
    Name   = "${var.name}_public_${element(var.azs, count.index)}"
    VPC    = "${var.name}"
    Owner  = "${var.owner}"
    Region = "${var.region["${var.buildenv}"]}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "default" {
  count                   = "${length(split(",",var.subnets))}"
  vpc_id                  = "${var.id}"
  cidr_block              = "${element(split(",", var.subnets), count.index)}"
  availability_zone       = "${element(split(",", lookup(var.azs, var.region["${var.buildenv}"])), count.index)}"
  map_public_ip_on_launch = "${var.allocate_public_ip}"

  //depends_on              = ["aws_internet_gateway", "aws_route_table.default"]
  tags {
    Name   = "${var.name}_public_${element(var.azs, count.index)}"
    VPC    = "${var.name}"
    Region = "${var.region["${var.buildenv}"]}"
    Owner  = "${var.owner}"
  }
}
