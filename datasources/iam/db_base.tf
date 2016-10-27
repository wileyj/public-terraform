data "aws_iam_policy_document" "db_base" {
  statement {
    sid = "${var.org_name_short}VPCDB"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

output "db_base" {
  value = "${data.aws_iam_policy_document.db_base.json}"
}
