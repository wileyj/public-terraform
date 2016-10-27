output "id" {
  value = "${aws_subnet.default.id}"
}

output "name" {
  value = "${aws_subnet.default.name}"
}

output "count" {
  value = "count: ${length( keys(var.subnets))}"
}
