data "aws_iam_policy_document" "lambda" {
  statement {
    sid    = "${var.org_name_short}LambdaEC2"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "ec2:DescribeNatGateways",
      "ec2:DeleteRoute",
      "ec2:ReplaceRoute",
      "ec2:CreateRoute",
      "ec2:DeleteNatGateway",
      "ec2:CreateNatGateway",
    ]
  }

  statement {
    sid    = "${var.org_name_short}LambdaLogging"
    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

// "Principal":{  "Service":[  "lambda.amazonaws.com"]},

