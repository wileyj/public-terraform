resource "aws_route53_zone" "default" {
    name = "${var.name}.${var.domain}"
    tags {
        Name   = "${var.name}.${var.domain}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "route53"
        Category    = "dns.zone"
    }
}
