resource "aws_eip" "default" {
    count = "${length(split(",",var.subnets))}"
    vpc = true
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
}

resource "aws_nat_gateway" "default" {
    count         = "${length(split(",",var.subnets))}"
    allocation_id = "${element(aws_eip.default.*.id, count.index)}"
    subnet_id     = "${element(aws_subnet.default.*.id, count.index)}"
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
    depends_on    = [
        "aws_eip.default",
        "aws_subnet.default"
    ]
}

resource "aws_route_table" "default" {
    count  = "${length(split(",",var.subnets))}"
    vpc_id = "${var.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${element(aws_nat_gateway.default.*.id, count.index)}"
    }
    tags {
        Name   = "${var.name}_private_${element(var.azones["${var.buildenv}"], count.index)}"
        VPC    = "${var.name}"
        Department  = "${var.owner}"
        Region = "${var.region["${var.buildenv}"]}"
        Environment = "${var.environment}"
        Application = "shared"
        Role        = "vpc"
        Service     = "vpc"
        Category    = "subnet"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
    depends_on = [
        "aws_nat_gateway.default"
    ]
}

resource "aws_subnet" "default" {
    count                   = "${length(split(",",var.subnets))}"
    vpc_id                  = "${var.id}"
    cidr_block              = "${element(split(",", var.subnets), count.index)}"
    availability_zone       = "${element(var.azones["${var.buildenv}"], count.index)}"
    map_public_ip_on_launch = "${var.allocate_public_ip}"
    tags {
        Name   = "${var.name}_public_${element(var.azones["${var.buildenv}"], count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "vpc"
        Service     = "vpc"
        Category    = "subnet"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
}
