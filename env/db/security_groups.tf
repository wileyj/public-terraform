module "internal_security_group" {
	source   = "../../modules/security_groups/"
	protocol = "-1"
	name = "${var.name}-internal"
	vpc = "${var.name}"
	source_address = "${lookup(var.cidr, var.region["${var.buildenv}"])}"
	from_port = "0"
	to_port = "65535"
	description = "${var.name} internal traffic"
}