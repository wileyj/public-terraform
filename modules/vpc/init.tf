resource "aws_vpc" "default" {
    cidr_block = "${var.cidr}"
    tags {
        Name        = "${var.name}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "vpc"
        Service     = "vpc"
        Category    = "vpc"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name   = "${var.org_name}.${var.name}.${var.region["${var.buildenv}"]}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
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
