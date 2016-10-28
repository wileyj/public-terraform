resource "aws_vpc_endpoint" "default" {
  vpc_id          = "${var.vpc_id}"
  service_name    = "${var.service_name}"
  route_table_ids = ["${var.route_table_ids}"]

  /*
      route_table_ids = [
        "${aws_route_table.prd_nated_b.id}",
        "${aws_route_table.prd_nated_c.id}",
        "${aws_route_table.prd_nated_d.id}",
        "${aws_route_table.prd_nated_e.id}",
      ]
    */
}
