data "aws_iam_policy_document" "base" {
  statement {
    sid    = "${var.org_name_short}BaseS3"
    effect = "Allow"

    resources = [
      "arn:aws:s3:::*",
    ]

    actions = [
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:PutBucketLogging",
      "s3:Get*",
      "s3:List*",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseLogging"
    effect = "Allow"

    resources = [
      "arn:aws:s3:::*",
    ]

    actions = [
      "logs:Describe*",
      "logs:Get*",
      "logs:Put*",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseMessage"
    effect = "Allow"

    resources = [
      "arn:aws:s3:::*",
    ]

    actions = [
      "sqs:SendMessage",
      "sqs:GetQueueUrl",
      "sns:Publish",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseOpsWorks"
    effect = "Allow"

    resources = [
      "arn:aws:s3:::*",
    ]

    actions = [
      "opsworks:*",
      "iam:CreateGroup*",
      "iam:CreateUser*",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseEC2"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "ec2:Describe*",
      "ec2:CreateTags*",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseELB"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "elasticloadbalancing:Describe*",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseCloudwatch"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:Describe*",
    ]
  }

  statement {
    sid    = "${var.org_name_short}BaseASG"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "autoscaling:Describe*",
    ]
  }
}

output "base" {
  value = "${data.aws_iam_policy_document.base.json}"
}
