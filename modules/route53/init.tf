resource "aws_route53_zone" "default" {
  name = "${var.name}.${var.domain}"

  tags {
    Name   = "${var.name}.${var.domain}"
    Owner  = "${var.owner}"
    Region = "${var.region["${var.buildenv}"]}"
  }
}
