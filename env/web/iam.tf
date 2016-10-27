module "iam_policies" {
  source = "../../datasources/iam/"
}

module "base_role" {
  source    = "../../modules/iam/role/"
  role_name = "${var.name}_base"

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

module "base_policy" {
  source      = "../../modules/iam/policy/"
  policy_name = "${var.name}Base"
  path        = "/"
  policy      = "${module.iam_policies.web_base}"
}

resource "aws_iam_policy_attachment" "policy_attach" {
  name       = "${var.name}-Base-attachment"
  roles      = ["${module.base_role.role_arn}"]
  policy_arn = "${module.base_policy.policy_arn}"

  //users = ["${aws_iam_user.user.name}"]

  //groups = ["${aws_iam_group.group.name}"]
}
