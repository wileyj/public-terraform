resource "aws_vpc_dhcp_options" "default" {
    domain_name         = "${var.name_lower}.${var.domain}"
    domain_name_servers = [ "AmazonProvidedDNS" ]
    /*domain_name_servers = [ "${lookup(var.nameserver, var.region["${var.buildenv}"])}", "AmazonProvidedDNS" ]*/
    tags {
        Name   = "${var.name_lower}.${var.domain}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Stage = ""
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "dhcp.options"
    }
    lifecycle {
        create_before_destroy = true
        /*prevent_destroy = true*/
    }
}

resource "aws_vpc_dhcp_options_association" "default" {
    vpc_id          = "${aws_vpc.default.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
    depends_on = [
        "aws_vpc_dhcp_options.default",
        "aws_vpc.default"
    ]
}
