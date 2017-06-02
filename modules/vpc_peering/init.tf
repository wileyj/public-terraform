resource "aws_vpc_peering_connection" "default" {
    peer_vpc_id = "${var.dest_id}"
    vpc_id      = "${var.source_id}"
    auto_accept = true
    tags {
        Name   = "VPC Peering between ${var.source_name} and ${var.dest_name}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
}
