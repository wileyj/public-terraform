data "aws_iam_policy_document" "core_base" {
  statement {
    sid = "${var.org_name_short}VPCCore"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

output "core_base" {
  value = "${data.aws_iam_policy_document.core_base.json}"
}
