resource "aws_route53_zone" "default" {
	name = "${var.name_lower}.${var.domain}"
	tags {
    	VPC = "${var.name_lower}"
		Name = "${var.name_lower}.${var.domain}"
  	}
}
