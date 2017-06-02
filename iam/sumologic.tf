data "aws_iam_policy_document" "sumologic_trust" {
    statement {
        sid  = "SumologicTrust"
        effect  = "Allow"
        principals {
            type = "Service"
            identifiers = [
                "ec2.amazonaws.com",
                "ecs-tasks.amazonaws.com"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}
data "template_file" "ops_sumologic" {
    template = "${file("datasources/iam/policies/ops/LOCAL.Ops.SumoLogic.json")}"
}

resource "aws_iam_policy" "ops_sumologic" {
    name = "${var.org_name}.Ops.SumoLogic"
    description = "${var.org_name}.Ops.SumoLogic"
    path        = "/${var.org_name}/Ops/"
    policy      = "${data.template_file.ops_sumologic.rendered}"
}

output "ops_sumologic_policy_arn" {
    value = "${aws_iam_policy.ops_sumologic.arn}"
}

resource "aws_iam_role" "sumologic" {
    name = "${var.org_name}.Ops.Sumologic"
    assume_role_policy = "${data.aws_iam_policy_document.sumologic_trust.json}"
    path        = "/${var.org_name}/Ops/"
}

resource "aws_iam_role_policy_attachment" "sumologic_role_policyattach" {
    role      = "${aws_iam_role.sumologic.name}"
    policy_arn = "${aws_iam_policy.ops_sumologic.arn}"
    depends_on = [
        "aws_iam_role.sumologic",
        "aws_iam_policy.ops_sumologic"
    ]
}
