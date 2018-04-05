/* route_table core -> bastion */
resource "aws_route" "core_bastion" {
  count                     = "${length(module.core.vpc_route_tables)}"
  route_table_id            = "${element(module.core.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.bastion.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.core_bastion.id}"

  depends_on = [
    "module.bastion",
    "module.core",
    "aws_vpc_peering_connection.core_bastion",
  ]
}

/* route_table bastion -> core */
resource "aws_route" "bastion_core" {
  count                     = "${length(module.bastion.vpc_route_tables)}"
  route_table_id            = "${element(module.bastion.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.core.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.core_bastion.id}"

  depends_on = [
    "module.bastion",
    "module.core",
    "aws_vpc_peering_connection.core_bastion",
  ]
}

/* route_table core -> app */
resource "aws_route" "core_app" {
  count                     = "${length(module.core.vpc_route_tables)}"
  route_table_id            = "${element(module.core.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.app.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.core_app.id}"

  depends_on = [
    "module.app",
    "module.core",
    "aws_vpc_peering_connection.core_app",
  ]
}

/* route_table app -> core */
resource "aws_route" "app_core" {
  count                     = "${length(module.app.vpc_route_tables)}"
  route_table_id            = "${element(module.app.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.core.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.core_app.id}"

  depends_on = [
    "module.app",
    "module.core",
    "aws_vpc_peering_connection.core_app",
  ]
}

/* route_table bastion -> app */
resource "aws_route" "bastion_app" {
  count                     = "${length(module.bastion.vpc_route_tables)}"
  route_table_id            = "${element(module.bastion.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.app.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_app.id}"

  depends_on = [
    "module.bastion",
    "module.app",
    "aws_vpc_peering_connection.bastion_app",
  ]
}

/* route_table app -> bastion */
resource "aws_route" "app_bastion" {
  count                     = "${length(module.app.vpc_route_tables)}"
  route_table_id            = "${element(module.app.vpc_route_tables, count.index)}"
  destination_cidr_block    = "${module.bastion.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_app.id}"

  depends_on = [
    "module.bastion",
    "module.core",
    "aws_vpc_peering_connection.bastion_app",
  ]
}
