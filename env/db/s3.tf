/*
module "s3" {
    source      = "../../modules/s3/"
    buckets     = ["${var.buckets["${var.buildenv}"]}"]
    acl         = "public"
    versioning  = "false"
    owner       = "${var.owner}"
    environment = "${var.environment}"
}
*/
/*
    hard to abstract really complex setups like lifecycle events and keep a single s3 module.
    maybe keep modules separate to a degree, and hardcode more complex buckets on a case by base basis
*/

