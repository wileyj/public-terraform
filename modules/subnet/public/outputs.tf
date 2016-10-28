output "id" {
  value = "${aws_subnet.default.id}"
}

output "name" {
  value = "${aws_subnet.default.name}"
}

output "public_subnets_id" {
  value = "${join(",", aws_subnet.default.*.id)}"
}
