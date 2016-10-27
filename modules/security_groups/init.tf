resource "aws_security_group" "default" {
	name = "${var.name}"
	description = "${var.description}"
	ingress {
		from_port = "${var.from_port}"
		to_port = "${var.to_port}"
		protocol = "${var.protocol}"
		cidr_blocks = ["${var.source_address}"]
	}
	tags {
		Name = "${var.name}"
		VPC = "${var.vpc}"
		Region = "${var.region["${var.buildenv}"]}"
		Owner = "${var.owner}"
	}
}
