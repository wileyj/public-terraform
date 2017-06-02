//rtb core -> bastion
resource "aws_route" "core_bastion" {
    count = "${length(module.core.vpc_subnets)}"
    route_table_id            = "${element(module.core.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.bastion.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_bastion.id}"
    depends_on                = [
        "module.bastion",
        "module.core",
        "aws_vpc_peering_connection.core_bastion"
    ]
}

//rtb bastion -> core
resource "aws_route" "bastion_core" {
    count = "${length(module.bastion.vpc_subnets)}"
    route_table_id            = "${element(module.bastion.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.core.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_bastion.id}"
    depends_on                = [
        "module.bastion",
        "module.core",
        "aws_vpc_peering_connection.core_bastion"
    ]
}


//rtb core -> app
resource "aws_route" "core_app" {
    count = "${length(module.core.vpc_subnets)}"
    route_table_id            = "${element(module.core.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.app.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_app.id}"
    depends_on                = [
        "module.app",
        "module.core",
        "aws_vpc_peering_connection.core_app"
    ]
}


//rtb app -> core
resource "aws_route" "app_core" {
    count = "${length(module.app.vpc_subnets)}"
    route_table_id            = "${element(module.app.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.core.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_app.id}"
    depends_on                = [
        "module.app",
        "module.core",
        "aws_vpc_peering_connection.core_app"
    ]
}

//rtb core -> web
resource "aws_route" "core_web" {
    count = "${length(module.core.vpc_subnets)}"
    route_table_id            = "${element(module.core.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.web.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_web.id}"
    depends_on                = [
        "module.web",
        "module.core",
        "aws_vpc_peering_connection.core_web"
    ]
}


//rtb web -> core
resource "aws_route" "web_core" {
    count = "${length(module.web.vpc_subnets)}"
    route_table_id            = "${element(module.web.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.core.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_web.id}"
    depends_on                = [
        "module.web",
        "module.core",
        "aws_vpc_peering_connection.core_web"
    ]
}

//rtb core -> db
resource "aws_route" "core_db" {
    count = "${length(module.core.vpc_subnets)}"
    route_table_id            = "${element(module.core.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.db.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_db.id}"
    depends_on                = [
        "module.db",
        "module.core",
        "aws_vpc_peering_connection.core_db"
    ]
}


//rtb db -> core
resource "aws_route" "db_core" {
    count = "${length(module.db.vpc_subnets)}"
    route_table_id            = "${element(module.db.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.core.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.core_db.id}"
    depends_on                = [
        "module.web",
        "module.core",
        "aws_vpc_peering_connection.core_db"
    ]
}


//rtb bastion -> app
resource "aws_route" "bastion_app" {
    count = "${length(module.bastion.vpc_subnets)}"
    route_table_id            = "${element(module.bastion.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.app.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_app.id}"
    depends_on                = [
        "module.bastion",
        "module.app",
        "aws_vpc_peering_connection.bastion_app"
    ]
}

//rtb app -> bastion
resource "aws_route" "app_bastion" {
    count = "${length(module.app.vpc_subnets)}"
    route_table_id            = "${element(module.app.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.bastion.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_app.id}"
    depends_on                = [
        "module.bastion",
        "module.core",
        "aws_vpc_peering_connection.bastion_app"
    ]
}

//rtb bastion -> web
resource "aws_route" "bastion_web" {
    count = "${length(module.bastion.vpc_subnets)}"
    route_table_id            = "${element(module.bastion.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.web.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_web.id}"
    depends_on                = [
        "module.bastion",
        "module.web",
        "aws_vpc_peering_connection.bastion_web"
    ]
}

//rtb web -> bastion
resource "aws_route" "web_bastion" {
    count = "${length(module.web.vpc_subnets)}"
    route_table_id            = "${element(module.web.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.bastion.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_web.id}"
    depends_on                = [
        "module.bastion",
        "module.web",
        "aws_vpc_peering_connection.bastion_web"
    ]
}

//rtb bastion -> db
resource "aws_route" "bastion_db" {
    count = "${length(module.bastion.vpc_subnets)}"
    route_table_id            = "${element(module.bastion.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.db.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_db.id}"
    depends_on                = [
        "module.bastion",
        "module.db",
        "aws_vpc_peering_connection.bastion_db"
    ]
}

//rtb db -> bastion
resource "aws_route" "db_bastion" {
    count = "${length(module.db.vpc_subnets)}"
    route_table_id            = "${element(module.db.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.bastion.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.bastion_db.id}"
    depends_on                = [
        "module.bastion",
        "module.db",
        "aws_vpc_peering_connection.bastion_db"
    ]
}

//rtb web -> app
resource "aws_route" "web_app" {
    count = "${length(module.web.vpc_subnets)}"
    route_table_id            = "${element(module.web.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.app.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.web_app.id}"
    depends_on                = [
        "module.web",
        "module.app",
        "aws_vpc_peering_connection.web_app"
    ]
}

//rtb app -> web
resource "aws_route" "app_web" {
    count = "${length(module.app.vpc_subnets)}"
    route_table_id            = "${element(module.app.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.web.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.web_app.id}"
    depends_on                = [
        "module.web",
        "module.app",
        "aws_vpc_peering_connection.web_app"
    ]
}

//rtb web -> db
resource "aws_route" "web_db" {
    count = "${length(module.web.vpc_subnets)}"
    route_table_id            = "${element(module.web.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.db.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.web_db.id}"
    depends_on                = [
        "module.web",
        "module.db",
        "aws_vpc_peering_connection.web_db"
    ]
}

//rtb db -> web
resource "aws_route" "db_web" {
    count = "${length(module.db.vpc_subnets)}"
    route_table_id            = "${element(module.db.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.web.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.web_db.id}"
    depends_on                = [
        "module.web",
        "module.db",
        "aws_vpc_peering_connection.web_app"
    ]
}

//rtb app -> db
resource "aws_route" "app_db" {
    count = "${length(module.app.vpc_subnets)}"
    route_table_id            = "${element(module.app.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.db.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.app_db.id}"
    depends_on                = [
        "module.app",
        "module.db",
        "aws_vpc_peering_connection.web_db"
    ]
}

//rtb db -> app
resource "aws_route" "db_app" {
    count = "${length(module.db.vpc_subnets)}"
    route_table_id            = "${element(module.db.vpc_subnets, count.index)}"
    destination_cidr_block    = "${module.app.vpc_cidr}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.app_db.id}"
    depends_on                = [
        "module.app",
        "module.db",
        "aws_vpc_peering_connection.app_db"
    ]
}
