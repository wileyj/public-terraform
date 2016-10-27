data "aws_iam_policy_document" "redshift" {
  statement {
    sid =  "${var.org_name_short}RedshiftBase",
    effect =  "Allow",
    resources =  [
      "*"
    ],
    actions =  [
      "s3:PutObject",
      "s3:GetObject",
      "redshift:*"
    ]
  }
}
