output "vpc_id" {
  value = "${aws_vpc.default.id}"
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

output "vpc_sg_id" {
  value = "${aws_security_group.default.id}"
}

# output "vpc_subnets" {
#   value = ["${aws_route_table.private.*.id}", "${aws_route_table.public.*.id}"]
# }
output "vpc_subnets" {
  value = ["${aws_subnet.private.*.id}", "${aws_subnet.public.*.id}"]
}

output "vpc_route_tables" {
  value = ["${aws_route_table.private.*.id}", "${aws_route_table.public.*.id}"]
}
