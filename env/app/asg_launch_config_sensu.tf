# resource "aws_launch_configuration" "sensu" {
#   name_prefix                 = "shared-sensu-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}."
#   image_id                    = "${lookup(var.coreos_use1_hvm_ami, "stable")}"
#   instance_type               = "${var.ecs_ec2}"
#   key_name                    = "${var.ec2_key}"
#   iam_instance_profile        = "${var.ecs_instance_profile}"
#   enable_monitoring           = true
#   associate_public_ip_address = false
#
#   security_groups = [
#     "${aws_security_group.default.id}",
#   ]
#
#   root_block_device {
#     volume_type           = "gp2"
#     volume_size           = "50"
#     delete_on_termination = true
#   }
#
#   ebs_block_device {
#     device_name           = "/dev/xvdf"
#     volume_type           = "standard"
#     volume_size           = "100"
#     delete_on_termination = true
#   }
#
#   lifecycle {
#     create_before_destroy = true
#   }
#
#   depends_on = [
#     "aws_vpc.default",
#     "aws_security_group.default",
#   ]
# }

