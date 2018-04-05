# module "elasticsearch" {
#   source                         = "modules/elasticsearch"
#   domain_name                    = "elk"
#   es_version                     = "6.2"
#   instance_type                  = "t2.small.elasticsearch"
#   instance_count                 = 3
#   dedicated_master_type          = false
#   management_iam_roles           = ["*"]
#   management_public_ip_addresses = []
#   es_zone_awareness              = "false"
#   ebs_volume_size                = 0
#   ebs_volume_type                = "gp2"
#   snapshot_start_hour            = 0
#
#   vpc_options = {
#     security_group_ids = [
#       "${module.core.vpc_sg_id}",
#     ]
#
#     subnet_ids = "${module.core.private_subnets}"
#   }
#
#   route53_zone      = "${module.core.route53_zone}"
#   ttl               = 5
#   environment       = "core"
#   retention_in_days = 7
# }

