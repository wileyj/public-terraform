resource "aws_vpc" "default" {
    cidr_block = "${lookup(var.cidr, var.region["${var.buildenv}"])}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name        = "${var.name}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
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
