# data "template_file" "default_sns" {
#   template = "${file("datasources/iam/policies/base/MOIL.Base.SNS.json")}"
# }

# data "aws_iam_policy_document" "default_sns_policy" {
#   # provider = "aws.regional"
#   policy_id = "${var.org_name}-${var.name}-SNS"
#   statement {
#     sid = "AllowSubscriptionFromSQS"
#     effect = "Allow"
#     principals {
#       type = "AWS"
#       identifiers = [
#         "arn:aws:iam::${var.account_id}:root"
#       ]
#     }
#     actions = [
#       "SNS:GetTopicAttributes",
#       "SNS:SetTopicAttributes",
#       "SNS:AddPermission",
#       "SNS:RemovePermission",
#       "SNS:DeleteTopic",
#       "SNS:Subscribe",
#       "SNS:ListSubscriptionsByTopic",
#       "SNS:Publish",
#       "SNS:Receive"
#     ]
#     resources = [
#       "${aws_sns_topic.default.arn}"
#     ]
#     condition {
#       test = "StringEquals"
#       variable = "AWS:SourceOwner"
#       values = [
#         "${var.account_id}"
#       ]
#     }
#   }
# }

module "sns_core_default_policy" {
  source          = "../../modules/iam"
  policy_id       = "${var.org_name}-${var.name}-SNS"
  sid             = "MOIL-Core-default"
  identifier      = "arn:aws:iam::${var.account_id}:root"
  resources       = ["${aws_sns_topic.default.arn}"]
  condition_name  = "AWS:SourceOwner"
  condition_value = ["${var.account_id}"]
  actions         = ["SNS:GetTopicAttributes", "SNS:SetTopicAttributes", "SNS:AddPermission", "SNS:RemovePermission", "SNS:DeleteTopic", "SNS:Subscribe", "SNS:ListSubscriptionsByTopic", "SNS:Publish", "SNS:Receive"]
}

# module.core.aws_sns_topic.default
resource "aws_sns_topic" "default" {
  name         = "${var.org_name}-${var.name}-Base"
  display_name = "${var.org_name} Default Notifications"
}

# module.core.aws_sns_topic_policy.default
resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.default.arn}"

  # policy = "${data.aws_iam_policy_document.default_sns_policy.json}"
  policy = "${module.sns_core_default_policy.default}"
}

# policy = "${data.template_file.default_sns.rendered}"
#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "${var.org_name}-${var.name}-SNS",
#   "Statement": [
#     {
#       "Sid": "First",
#       "Effect": "Allow",
#       "Principal": {
#           "AWS": [
#               "arn:aws:iam::${var.account_id}:root"
#           ]
#       },
#       "Action": [
#         "SNS:Subscribe",
#         "SNS:SetTopicAttributes",
#         "SNS:RemovePermission",
#         "SNS:Receive",
#         "SNS:Publish",
#         "SNS:ListSubscriptionsByTopic",
#         "SNS:GetTopicAttributes",
#         "SNS:DeleteTopic",
#         "SNS:AddPermission"
#       ],
#       "Resource": "${aws_sns_topic.default.arn}"
#     }
#   ]
# }
# POLICY
# }


# module.iam.template_file.moil_base_cloudfront

