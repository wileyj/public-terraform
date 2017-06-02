data "template_file" "core_base" {
    template = "${file("datasources/iam/policies/core/LOCAL.Core.Base.json")}"
}

resource "aws_iam_role" "core_base" {
    name = "${var.org_name}.Core.Base"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_trust.json}"
    path        = "/${var.org_name}/Core/"
}

resource "aws_iam_policy" "core_base" {
    name = "${var.org_name}.Core.Base"
    description = "${var.org_name}.Core.Base"
    path        = "/${var.org_name}/Core/"
    policy      = "${data.template_file.core_base.rendered}"
}

output "core_base_policy_arn" {
    value = "${aws_iam_policy.core_base.arn}"
}

resource "aws_iam_role_policy_attachment" "core_base_role_policyattach" {
    role      = "${aws_iam_role.core_base.name}"
    policy_arn = "${aws_iam_policy.core_base.arn}"
    depends_on = [
        "aws_iam_role.core_base",
        "aws_iam_policy.core_base"
    ]
}
