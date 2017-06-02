output "id" {
    value = "${aws_vpc.default.id}"
}

output "name" {
    value = "${aws_vpc.default.name}"
}

output "cidr" {
    value = "${aws_vpc.default.cidr_block}"
}

output "gateway_id" {
    value = "${aws_internet_gateway.default.id}"
}
