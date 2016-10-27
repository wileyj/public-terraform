data "aws_iam_policy_document" "appserver" {
  statement {
    sid =  "${var.org_name_short}AppServer",
    effect =  "Allow",
    resources =  [
      "*"
    ],
    actions =  [
      "s3:PutObject",
      "s3:GetObject"

    ]
  }
}
