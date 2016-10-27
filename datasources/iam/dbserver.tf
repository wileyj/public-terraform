data "aws_iam_policy_document" "dbserver" {
  statement {
    sid =  "${var.org_name_short}DBServerBase",
    effect =  "Allow",
    resources =  [
      "*"
    ],
    actions =  [
      "s3:*",
    ]
  }
}
