module "s3_endpoint" {
  source          = "../../modules/networking/s3_endpoint"
  vpc_id          = ""
  service_name    = ""
  route_table_ids = ""
}

/*
resource "aws_vpc_endpoint" "prd_endpoint_s3" {
  vpc_id       = "${aws_vpc.production.id}"
  service_name = "com.amazonaws.us-east-1.s3"

  route_table_ids = [
    "${aws_route_table.prd_nated_b.id}",
    "${aws_route_table.prd_nated_c.id}",
    "${aws_route_table.prd_nated_d.id}",
    "${aws_route_table.prd_nated_e.id}",
  ]
}
*/

