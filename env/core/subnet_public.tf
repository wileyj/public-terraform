
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name   = "${var.org_name}.${var.name}.${var.region["${var.buildenv}"]}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "internet.gateway"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
    depends_on = [
        "aws_vpc.default"
    ]
}

resource "aws_route_table" "public" {
    count = "${length(split(",", lookup(var.public_subnets, var.region["${var.buildenv}"])))}"
    vpc_id = "${aws_vpc.default.id}"
    /*route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }*/
    tags {
        Name   = "${var.org_name}.${var.name}.public.${element(var.azones["${var.buildenv}"], count.index)}"
        VPC    = "${var.name}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
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
        "aws_internet_gateway.default",
        "aws_route_table.public"
    ]
}

resource "aws_route" "public" {
    count = "${length(split(",", lookup(var.public_subnets, var.region["${var.buildenv}"])))}"
    route_table_id            = "${element(aws_route_table.public.*.id, count.index)}"
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.default.id}"
    depends_on                = [
        "aws_route_table.public"
    ]
}

resource "aws_route_table_association" "public" {
    count = "${length(split(",", lookup(var.public_subnets, var.region["${var.buildenv}"])))}"
    subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
    depends_on = [
        "aws_route_table.public"
    ]
}

resource "aws_subnet" "public" {
    count = "${length(split(",", lookup(var.public_subnets, var.region["${var.buildenv}"])))}"
    vpc_id                  = "${aws_vpc.default.id}"
    cidr_block              = "${element(split(",", lookup(var.public_subnets, var.region["${var.buildenv}"])), count.index)}"
    availability_zone       = "${element(var.azones["${var.buildenv}"], count.index)}"
    map_public_ip_on_launch = "false"
    tags {
        Name   = "${var.org_name}.${var.name}.public.${element(var.azones["${var.buildenv}"], count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
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
        "aws_route_table.public",
        "aws_vpc.default"
    ]
}
