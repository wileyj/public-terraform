data "aws_iam_policy_document" "webserver" {
  statement {
    sid    = "${var.org_name_short}WebServer"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]
  }
}
