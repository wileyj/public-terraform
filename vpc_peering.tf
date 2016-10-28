

/*
// VPC Peering
module "peer_core_bastion" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_core.vpc_id}"
  dest_id     = "${module.env_bastion.vpc_id}"
  source_name = "${module.env_core.vpc_name}"
  dest_name   = "${module.env_bastion.vpc_name}"
}

module "peer_core_app" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_core.vpc_id}"
  dest_id     = "${module.env_app.vpc_id}"
  source_name = "${module.env_core.vpc_name}"
  dest_name   = "${module.env_app.vpc_name}"
}

module "peer_core_web" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_core.vpc_id}"
  dest_id     = "${module.env_web.vpc_id}"
  source_name = "${module.env_core.vpc_name}"
  dest_name   = "${module.env_web.vpc_name}"
}

module "peer_core_db" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_core.vpc_id}"
  dest_id     = "${module.env_db.vpc_id}"
  source_name = "${module.env_core.vpc_name}"
  dest_name   = "${module.env_db.vpc_name}"
}

module "peer_bastion_app" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_bastion.vpc_id}"
  dest_id     = "${module.env_app.vpc_id}"
  source_name = "${module.env_bastion.vpc_name}"
  dest_name   = "${module.env_app.vpc_name}"
}

module "peer_bastion_web" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_bastion.vpc_id}"
  dest_id     = "${module.env_web.vpc_id}"
  source_name = "${module.env_bastion.vpc_name}"
  dest_name   = "${module.env_web.vpc_name}"
}

module "peer_bastion_db" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_bastion.vpc_id}"
  dest_id     = "${module.env_db.vpc_id}"
  source_name = "${module.env_bastion.vpc_name}"
  dest_name   = "${module.env_db.vpc_name}"
}

module "peer_web_app" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_web.vpc_id}"
  dest_id     = "${module.env_app.vpc_id}"
  source_name = "${module.env_web.vpc_name}"
  dest_name   = "${module.env_app.vpc_name}"
}

module "peer_web_db" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_web.vpc_id}"
  dest_id     = "${module.env_db.vpc_id}"
  source_name = "${module.env_web.vpc_name}"
  dest_name   = "${module.env_db.vpc_name}"
}

module "peer_app_db" {
  source      = "modules/vpc_peering/"
  source_id   = "${module.env_app.vpc_id}"
  dest_id     = "${module.env_db.vpc_id}"
  source_name = "${module.env_app.vpc_name}"
  dest_name   = "${module.env_db.vpc_name}"
}
*/

