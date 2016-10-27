resource "aws_vpc_dhcp_options" "default" {
    domain_name = "${var.vpc_domain}"
    domain_name_servers = ["127.0.0.1", "${var.nameserver}"]
    ntp_servers = [
		"server 0.amazon.pool.ntp.org",
		"server 1.amazon.pool.ntp.org",
		"server 2.amazon.pool.ntp.org",
		"server 3.amazon.pool.ntp.org"
	]
    netbios_name_servers = ["127.0.0.1"]
    netbios_node_type = 2
    tags {
        Name = "${var.vpc_domain}"
		VPC = "${var.name}"
		Region = "${var.region["${var.buildenv}"]}"
		Owner = "${var.owner}"
    }
}
