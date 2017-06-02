resource "aws_iam_instance_profile" "local_base" {
    name  = "LOCAL.Base"
    role      = "${aws_iam_role.local_base_role.name}"
}

output "local_base_profile" {
    value = "${aws_iam_instance_profile.local_base.id}"
}
