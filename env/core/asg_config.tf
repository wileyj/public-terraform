data "template_file" "ecs" {
  count    = "${length(var.ecs_env["${var.buildenv}"])}"
  template = "${file("datasources/userdata/ecs.yaml")}"

  vars {
    ecs_cluster_name  = "${element(aws_ecs_cluster.shared.*.name, count.index)}"
    ecs_host_name     = "shared-ecs-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}.${var.domain}"
    registrator_image = "${var.registrator_image}"
    docker_auth_key   = "${var.docker_auth_key}"
    docker_auth_id    = "${var.docker_auth_id}"
    quay_auth_key     = "${var.quay_auth_key}"
    quay_auth_id      = "${var.quay_auth_id}"
  }
}

/* name like: production.shared.core.us-east-1.00b6b1e095332713a8827361e7 */
resource "aws_launch_configuration" "ecs" {
  count                       = "${length(var.ecs_env["${var.buildenv}"])}"
  name_prefix                 = "shared-ecs-000.${element(var.ecs_env["${var.buildenv}"], count.index)}.${var.environment}.${var.region["${var.buildenv}"]}."
  image_id                    = "${lookup(var.coreos_use1_hvm_ami, "stable")}"
  instance_type               = "${var.ecs_ec2}"
  key_name                    = "${var.ec2_key}"
  user_data                   = "${element(data.template_file.ecs.*.rendered, count.index)}"
  iam_instance_profile        = "${var.ecs_instance_profile}"
  enable_monitoring           = true
  associate_public_ip_address = false

  security_groups = [
    "${aws_security_group.ecs.id}",
  ]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "50"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_type           = "standard"
    volume_size           = "100"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    "aws_vpc.default",
    "aws_ecs_cluster.shared",
    "data.template_file.ecs",
    "aws_security_group.ecs",
  ]
}
