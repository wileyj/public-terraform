/*
resource "aws_s3_bucket" "default" {
    count  = "${length(split(",",var.buckets))}"
    bucket = "${element(split(",", var.buckets), count.index)}"
    acl    = "${var.acl}"
    versioning {
        enabled = "${var.versioning}"
    }
    tags {
        Name        = "${element(split(",", var.buckets), count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region      = "${var.region["${var.buildenv}" ]}"
        Application = "shared"
        Role        = "${element(split(",", var.buckets), count.index)}"
        Service     = "s3"
        Category    = "bucket"
    }
}*/

resource "aws_s3_bucket" "default" {
    count  = "${length(var.buckets)}"
    bucket = "${element(var.buckets, count.index)}"
    acl    = "${var.acl}"
    versioning {
        enabled = "${var.versioning}"
    }
    tags {
        Name        = "${element(var.buckets, count.index)}"
        Department  = "${var.owner}"
        Environment = "${var.environment}"
        Region      = "${var.region["${var.buildenv}"]}"
        Application = "shared"
        Role        = "${element(var.buckets, count.index)}"
        Service     = "s3"
        Category    = "bucket"
    }
}
