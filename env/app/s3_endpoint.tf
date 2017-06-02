resource "aws_vpc_endpoint" "default" {
    vpc_id          = "${aws_vpc.default.id}"
    service_name    = "com.amazonaws.${var.region["${var.buildenv}"]}.s3"
    route_table_ids = [
        "${aws_route_table.public.*.id}",
        "${aws_route_table.private.*.id}"
    ]
    depends_on = [
        "aws_subnet.public",
        "aws_subnet.private",
        "aws_vpc.default"
    ]

}
