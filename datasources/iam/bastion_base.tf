data "aws_iam_policy_document" "bastion_base" {
  statement {
    sid = "${var.org_name_short}VPCBastion"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

output "bastion_base" {
  value = "${data.aws_iam_policy_document.bastion_base.json}"
}
