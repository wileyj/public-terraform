module "dhcp" {
  source     = "../../modules/networking/dhcp"
  vpc_domain = "${var.name_lower}.${var.domain}"

  //nameserver = "${var.nameserver}"
  #nameserver = "${ element(values(var.nameserver), 0 )}"
  nameserver = "${lookup(var.nameserver, var.region["${var.buildenv}"])}"
  name       = "${var.name}"
}

resource "aws_vpc_dhcp_options_association" "dhcp_association" {
  vpc_id          = "${module.vpc.id}"
  dhcp_options_id = "${module.dhcp.id}"
}
