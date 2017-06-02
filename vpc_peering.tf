/* VPC Peering */

resource "aws_vpc_peering_connection" "core_bastion" {
    peer_vpc_id = "${module.bastion.vpc_id}"
    vpc_id      = "${module.core.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.core.vpc_name}::${module.bastion.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.bastion",
        "module.core"
    ]
}

resource "aws_vpc_peering_connection" "core_app" {
    peer_vpc_id = "${module.app.vpc_id}"
    vpc_id      = "${module.core.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.core.vpc_name}::${module.app.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.app",
        "module.core"
    ]
}

resource "aws_vpc_peering_connection" "core_web" {
    peer_vpc_id = "${module.web.vpc_id}"
    vpc_id      = "${module.core.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.core.vpc_name}::${module.web.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.web",
        "module.core"
    ]
}


resource "aws_vpc_peering_connection" "core_db" {
    peer_vpc_id = "${module.db.vpc_id}"
    vpc_id      = "${module.core.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.core.vpc_name}::${module.db.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.db",
        "module.core"
    ]
}


resource "aws_vpc_peering_connection" "bastion_app" {
    peer_vpc_id = "${module.app.vpc_id}"
    vpc_id      = "${module.bastion.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.bastion.vpc_name}::${module.app.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.bastion",
        "module.app"
    ]
}


resource "aws_vpc_peering_connection" "bastion_web" {
    peer_vpc_id = "${module.web.vpc_id}"
    vpc_id      = "${module.bastion.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.bastion.vpc_name}::${module.web.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.bastion",
        "module.web"
    ]
}


resource "aws_vpc_peering_connection" "bastion_db" {
    peer_vpc_id = "${module.db.vpc_id}"
    vpc_id      = "${module.bastion.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.bastion.vpc_name}::${module.db.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.bastion",
        "module.db"
    ]
}

resource "aws_vpc_peering_connection" "web_app" {
    peer_vpc_id = "${module.app.vpc_id}"
    vpc_id      = "${module.web.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.web.vpc_name}::${module.app.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.web",
        "module.app"
    ]
}

resource "aws_vpc_peering_connection" "web_db" {
    peer_vpc_id = "${module.db.vpc_id}"
    vpc_id      = "${module.web.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.web.vpc_name}::${module.db.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.web",
        "module.db"
    ]
}

resource "aws_vpc_peering_connection" "app_db" {
    peer_vpc_id = "${module.db.vpc_id}"
    vpc_id      = "${module.app.vpc_id}"
    auto_accept = true
    accepter {
        allow_remote_vpc_dns_resolution = true
    }
    requester {
        allow_remote_vpc_dns_resolution = true
    }
    tags {
        Name   = "${module.app.vpc_name}::${module.db.vpc_name}"
        Department  = "${var.owner}"
        Environment = "Global"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "networking"
        Service     = "vpc"
        Category    = "vpc.peering"
    }
    lifecycle {
        create_before_destroy = true
    }
    depends_on = [
        "module.app",
        "module.db"
    ]
}
