output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "igw" {
  value = "${aws_internet_gateway.default.id}"
}

output "vpc_name" {
  value = "${var.name}"
}

output "vpc_name_lower" {
  value = "${var.name_lower}"
}

output "vpc_cidr" {
  value = "${lookup(var.cidr, var.region["${var.buildenv}"])}"
}

output "vpc_sg_name" {
  value = "${var.org_name}.${var.name}.Internal"
}

output "ecs_sg_name" {
  value = "${aws_security_group.ecs.name}"
}

output "vpc_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "vpc_sg_ecs_id" {
  value = "${aws_security_group.ecs.id}"
}

output "vpc_subnets" {
  value = ["${aws_subnet.private.*.id}", "${aws_subnet.public.*.id}", "${aws_subnet.ecs.*.id}"]
}

output "vpc_route_tables" {
  value = ["${aws_route_table.private.*.id}", "${aws_route_table.public.*.id}", "${aws_route_table.ecs.*.id}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

output "ecs_subnets" {
  value = ["${aws_subnet.ecs.*.id}"]
}

output "route53_zone" {
  value = "${aws_route53_zone.default.zone_id}"
}

output "route53_zone_name" {
  value = "${aws_route53_zone.default.name}"
}

output "ecr_repo" {
  value = "${aws_ecr_repository.default.repository_url}"
}

output "ecs_cluster" {
  value = "${aws_ecs_cluster.shared.id}"
}

output "environment" {
  value = "${var.environment}"
}

output "nat_gateways" {
  value = "${aws_nat_gateway.default.*.public_ip}"
}
