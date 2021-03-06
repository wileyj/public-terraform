resource "aws_iam_instance_profile" "moil_base" {
  name = "MOIL.Base"
  role = "${aws_iam_role.moil_base_role.name}"
}

output "moil_base_profile" {
  value = "${aws_iam_instance_profile.moil_base.id}"
}

resource "aws_iam_instance_profile" "moil_base_ecs" {
  name = "MOIL.Base.ECS"
  role = "${aws_iam_role.moil_base_ecs_role.name}"
}

output "moil_base_ecs_profile" {
  value = "${aws_iam_instance_profile.moil_base_ecs.id}"
}
