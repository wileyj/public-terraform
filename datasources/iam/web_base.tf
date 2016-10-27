data "aws_iam_policy_document" "web_base" {
  statement {
    sid = "${var.org_name_short}VPCWeb"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

output "web_base" {
  value = "${data.aws_iam_policy_document.web_base.json}"
}
