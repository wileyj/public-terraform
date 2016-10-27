provider "aws" {
  //region = "${var.region}"
  region = "${var.region["${var.buildenv}"]}"
}

module "env_global" {
  source = "global/"
}

module "env_core" {
  source = "env/core"
}

module "env_bastion" {
  source = "env/bastion"
}

module "env_app" {
  source = "env/app"
}

module "env_web" {
  source = "env/web"
}

module "env_db" {
  source = "env/db"
}
