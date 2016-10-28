module "s3_endpoint" {
	source          = "../../modules/networking/s3_endpoint"
	vpc_id          = "${module.vpc.id}"
	service_name    = "com.amazonaws.${var.region["${var.buildenv}"]}.s3"
	route_table_ids = "${join(",",module.public_subnet.public_subnets_id)}"
}
