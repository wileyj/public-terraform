resource "aws_iam_instance_profile" "moil_base" {
    name  = "MOIL.Base"
    role      = "${aws_iam_role.moil_base_role.name}"
}

output "moil_base_profile" {
    value = "${aws_iam_instance_profile.moil_base.id}"
}
