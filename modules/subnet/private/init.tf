resource "aws_eip" "default" {
  vpc = true
}

resource "aws_nat_gateway" "default" {
  count         = "${length(split(",",var.subnets))}"
  allocation_id = "${element(aws_eip.default.*.id, count.index)}"
  subnet_id     = "${aws_subnet.default.id}"
  subnet_id     = "${element(aws_subnet.default.*.id, count.index)}"
  depends_on    = ["aws_eip.default"]
}

resource "aws_route_table" "default" {
  count  = "${length(split(",",var.subnets))}"
  vpc_id = "${var.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.default.*.id, count.index)}"
  }

  tags {
    Name   = "${var.name}_private_${element(var.azs, count.index)}"
    VPC    = "${var.name}"
    Owner  = "${var.owner}"
    Region = "${var.region["${var.buildenv}"]}"
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
