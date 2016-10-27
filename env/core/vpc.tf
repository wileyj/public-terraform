module "vpc" {
	source   = "../../modules/vpc/"
	name = "${var.name}"
	cidr = "${lookup(var.cidr, var.region["${var.buildenv}"])}"
}

module "public_subnet" {
	source   = "../../modules/subnet/public/"
	id   = "${module.vpc.id}"
	name = "${module.vpc.name}"
	subnets = "${lookup(var.public_subnets, var.region["${var.buildenv}"])}"
}

module "private_subnet" {
	source   = "../../modules/subnet/private/"
	id   = "${module.vpc.id}"
	name = "${module.vpc.name}"
	subnets = "${lookup(var.private_subnets, var.region["${var.buildenv}"])}"
}
