/* define which provider to use */
provider "aws" {
  region = "${var.region["${var.buildenv}"]}"
}

/* process all global iam definitions */
module "iam" {
  source = "iam/"
}

/* builds out the bastion VPC */
module "bastion" {
  source               = "env/bastion"
  ecs_instance_profile = "${module.iam.moil_base_ecs_profile}"
}

/* builds the core vpc with a single ecs shared asset */
module "core" {
  source               = "env/core"
  bastion_cidr         = "${module.bastion.vpc_cidr}"
  ecs_instance_profile = "${module.iam.moil_base_ecs_profile}"
  ecs_base_role        = "${module.iam.moil_base_ecs_role}"
  ecs_base_policy      = "${module.iam.moil_base_ecs_policy_arn}"
}

/* builds the app vpc with application level ecs assets */
module "app" {
  source               = "env/app"
  bastion_cidr         = "${module.bastion.vpc_cidr}"
  ecs_instance_profile = "${module.iam.moil_base_ecs_profile}"
}

module "lambda" {
  source = "modules/lambda/"
}

/*
module "web" {
  source               = "env/web"
  bastion_cidr         = "${module.bastion.vpc_cidr}"
  ecs_instance_profile = "${module.iam.moil_base_profile}"
}

module "db" {
  source               = "env/db"
  bastion_cidr         = "${module.bastion.vpc_cidr}"
  ecs_instance_profile = "${module.iam.moil_base_profile}"
}
*/

