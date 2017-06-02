resource "aws_route53_zone" "default" {
    name = "${var.name_lower}.${var.domain}"
    vpc_id  = "${aws_vpc.default.id}"
    vpc_region = "${var.region["${var.buildenv}"]}"
    comment = "${var.name_lower}.${var.domain}"
    tags {
        Name   = "${var.name_lower}.${var.domain}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "route53"
        Category    = "dns.zone"
    }
    depends_on = [
        "aws_vpc.default"
    ]
}
