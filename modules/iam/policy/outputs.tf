output "policy_name" {
    value = "${aws_iam_policy.default.name}"
}

output "policy_arn" {
    value = "${aws_iam_policy.default.arn}"
}
