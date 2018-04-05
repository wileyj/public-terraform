data "template_file" "ops_snapshot" {
    template = "${file("datasources/iam/policies/ops/MOIL.Ops.Snapshot.json")}"
}
data "template_file" "ops_packer" {
    template = "${file("datasources/iam/policies/ops/MOIL.Ops.Packer.json")}"
}
data "template_file" "ops_admin" {
    template = "${file("datasources/iam/policies/ops/MOIL.Ops.Admin.json")}"
}
data "template_file" "ops_restricted" {
    template = "${file("datasources/iam/policies/ops/MOIL.Ops.Restricted.json")}"
}

resource "aws_iam_policy" "ops_snapshot" {
    name = "${var.org_name}.Ops.Snapshot"
    description = "${var.org_name}.Ops.Snapshot"
    path        = "/${var.org_name}/Ops/"
    policy      = "${data.template_file.ops_snapshot.rendered}"
}
output "ops_snapshot_policy_arn" {
    value = "${aws_iam_policy.ops_snapshot.arn}"
}

resource "aws_iam_policy" "ops_packer" {
    name = "${var.org_name}.Ops.Packer"
    description = "${var.org_name}.Ops.Packer"
    path        = "/${var.org_name}/Ops/"
    policy      = "${data.template_file.ops_packer.rendered}"
}
output "ops_packer_policy_arn" {
    value = "${aws_iam_policy.ops_packer.arn}"
}

resource "aws_iam_policy" "ops_restricted" {
    name = "${var.org_name}.Ops.Restricted"
    description = "${var.org_name}.Ops.Restricted"
    path        = "/${var.org_name}/Ops/"
    policy      = "${data.template_file.ops_restricted.rendered}"
}
output "ops_restricted_policy_arn" {
    value = "${aws_iam_policy.ops_restricted.arn}"
}

resource "aws_iam_policy" "ops_admin" {
    name = "${var.org_name}.Ops.Admin"
    description = "${var.org_name}.Ops.Admin"
    path        = "/${var.org_name}/Ops/"
    policy      = "${data.template_file.ops_admin.rendered}"
}
output "ops_admin_policy_arn" {
    value = "${aws_iam_policy.ops_snapshot.arn}"
}
