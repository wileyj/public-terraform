module "iam_policies" {
  source   = "../datasources/iam/"
}

module "global_base_role" {
  source = "../modules/iam/role/"
  role_name = "${var.org_name}_Base"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

module "global_base_policy" {
  source = "../modules/iam/policy/"
  policy_name = "${var.org_name}Base"
  path = "/"
  policy   = "${module.iam_policies.base}"
}

resource "aws_iam_policy_attachment" "global_policy_attach" {
    name = "${var.org_name}-Base-attachment"
    roles = ["${module.global_base_role.role_arn}"]
    policy_arn = "${module.global_base_policy.policy_arn}"
    //users = ["${aws_iam_user.user.name}"]
    //groups = ["${aws_iam_group.group.name}"]
}
