data "template_file" "bastion_base" {
    template = "${file("datasources/iam/policies/bastion/LOCAL.Bastion.Base.json")}"
}

resource "aws_iam_role" "bastion_base" {
    name = "${var.org_name}.Bastion.Base"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_trust.json}"
    path        = "/${var.org_name}/Bastion/"
}
resource "aws_iam_policy" "bastion_base" {
    name = "${var.org_name}.Bastion.Base"
    description = "${var.org_name}.Bastion.Base"
    path        = "/${var.org_name}/Bastion/"
    policy      = "${data.template_file.bastion_base.rendered}"
}
output "bastion_base_policy_arn" {
    value = "${aws_iam_policy.bastion_base.arn}"
}

resource "aws_iam_role_policy_attachment" "bastion_base_role_policyattach" {
    role      = "${aws_iam_role.bastion_base.name}"
    policy_arn = "${aws_iam_policy.bastion_base.arn}"
    depends_on = [
        "aws_iam_role.bastion_base",
        "aws_iam_policy.bastion_base"
    ]
}
