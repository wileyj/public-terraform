resource "aws_vpc" "default" {
  cidr_block = "${var.cidr}"

  tags {
    Name   = "${var.name}"
    Owner  = "${var.owner}"
    VPC    = "${var.name}"
    Region = "${var.region["${var.buildenv}"]}"
  }
}
