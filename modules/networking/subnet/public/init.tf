resource "aws_route_table" "default" {
    count  = "${length(split(",",var.subnets))}"
    vpc_id = "${var.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${var.gateway_id}"
    }
    tags {
        Name   = "${var.name}_public_${element(var.azones["${var.buildenv}"], count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "route.table"
    }
    lifecycle {
        create_before_destroy = true
        prevent_destroy = true
    }
}

resource "aws_subnet" "default" {
    count                   = "${length(split(",",var.subnets))}"
    vpc_id                  = "${var.id}"
    cidr_block              = "${element(split(",", var.subnets), count.index)}"
    availability_zone       = "${element(var.azones["${var.buildenv}"], count.index)}"
    map_public_ip_on_launch = "${var.allocate_public_ip}"
    /* depends_on              = ["aws_internet_gateway", "aws_route_table.default"]*/
    tags {
        Name   = "${var.name}_public_${element(var.azones["${var.buildenv}"], count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "subnet"
    }
    lifecycle {
        create_before_destroy = true
        prevent_destroy = true
    }
}
