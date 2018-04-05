#
# data "aws_iam_policy_document" "default_sqs_policy" {
#   # provider = "aws.regional"
#   policy_id = "${var.org_name}-${var.name}-SQS"
#   statement {
#     sid = "MOIL-Core-default"
#     effect = "Allow"
#     principals {
#       type = "AWS"
#       identifiers = [
#         "arn:aws:iam::${var.account_id}:root"
#       ]
#     }
#     actions = [
#       "SQS:SendMessage",
#       "SQS:ListQueues"
#     ]
#     resources = [
#       "${aws_sns_topic.default.arn}"
#     ]
#     condition {
#       test = "StringEquals"
#       variable = "AWS:SourceArn"
#       values = [
#         "${aws_sqs_queue.default.arn}"
#       ]
#     }
#   }
# }

# module.core.aws_sqs_queue.default
resource "aws_sqs_queue" "default" {
  name                      = "${var.org_name}-${var.name}-Base"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.default_deadletter.arn}\",\"maxReceiveCount\":4}"
}

module "sqs_core_default_policy" {
  source          = "../../modules/iam"
  policy_id       = "${var.org_name}-${var.name}-SQS"
  sid             = "MOIL-Core-default"
  identifier      = "arn:aws:iam::${var.account_id}:root"
  resources       = ["${aws_sqs_queue.default.arn}"]
  condition_name  = "AWS:SourceArn"
  condition_value = ["${aws_sqs_queue.default.arn}"]
  actions         = ["SQS:SendMessage", "SQS:ListQueues"]
}

# module.core.aws_sqs_queue_policy.default
resource "aws_sqs_queue_policy" "default" {
  queue_url = "${aws_sqs_queue.default.id}"
  policy    = "${module.sqs_core_default_policy.default}"

  # policy    = "${data.aws_iam_policy_document.default_sqs_policy.json}"
}

# module.core.aws_sqs_queue.default
resource "aws_sqs_queue" "default_deadletter" {
  name                      = "${var.org_name}-${var.name}-DeadLetter"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

module "sqs_core_deadletter_policy" {
  source          = "../../modules/iam"
  policy_id       = "${var.org_name}-${var.name}-SQS"
  sid             = "MOIL-Core-deadletter"
  identifier      = "arn:aws:iam::${var.account_id}:root"
  resources       = ["${aws_sqs_queue.default_deadletter.arn}"]
  condition_name  = "AWS:SourceArn"
  condition_value = ["${aws_sqs_queue.default_deadletter.arn}"]
  actions         = ["SQS:SendMessage", "SQS:ListQueues"]
}

# module.core.aws_sqs_queue_policy.default_deadletter
resource "aws_sqs_queue_policy" "default_deadletter" {
  queue_url = "${aws_sqs_queue.default_deadletter.id}"
  policy    = "${module.sqs_core_deadletter_policy.default}"
}
