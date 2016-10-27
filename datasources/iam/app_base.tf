data "aws_iam_policy_document" "app_base" {
  statement {
    sid = "${var.org_name_short}VPCApp"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

output "app_base" {
  value = "${data.aws_iam_policy_document.app_base.json}"
}
