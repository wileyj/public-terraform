resource "aws_vpc_peering_connection" "default" {
  peer_vpc_id = "${var.dest_id}"
  vpc_id      = "${var.source_id}"
  auto_accept = true

  tags {
    Name   = "VPC Peering between ${var.source_name} and ${var.dest_name}"
    Owner  = "${var.owner}"
    Region = "${var.region["${var.buildenv}"]}"
  }
}
