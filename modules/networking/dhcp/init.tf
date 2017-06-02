resource "aws_vpc_dhcp_options" "default" {
    domain_name         = "${var.vpc_domain}"
    domain_name_servers = ["${var.nameserver}"]
    /*ntp_servers          = [
        "0.amazon.pool.ntp.org",
        "1.amazon.pool.ntp.org",
        "2.amazon.pool.ntp.org",
        "3.amazon.pool.ntp.org"
    ]*/
    netbios_name_servers = ["127.0.0.1"]
    netbios_node_type    = 2
    tags {
        Name   = "${var.vpc_domain}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region = "${var.region["${var.buildenv}"]}"
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
