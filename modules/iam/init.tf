data "aws_iam_policy_document" "default" {
  policy_id = "${var.policy_id}"

  statement {
    sid    = "${var.sid}"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "${var.identifier}",
      ]
    }

    actions   = "${var.actions}"
    resources = ["${var.resources}"]

    condition {
      test     = "StringEquals"
      variable = "${var.condition_name}"

      values = [
        "${var.condition_value}",
      ]
    }
  }
}

output "default" {
  value = "${data.aws_iam_policy_document.default.json}"
}

data "aws_iam_policy_document" "service" {
  policy_id = "${var.policy_id}"

  statement {
    sid    = "${var.sid}"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "${var.identifier}",
      ]
    }

    actions   = "${var.actions}"
    resources = ["${var.resources}"]
  }
}

output "service" {
  value = "${data.aws_iam_policy_document.service.json}"
}
