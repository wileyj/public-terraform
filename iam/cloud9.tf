data "aws_iam_policy_document" "cloud9_users" {
  policy_id = "${var.org_name}-Cloud9-Users"

  statement {
    sid    = "${var.org_name}Cloud9Users"
    effect = "Deny"

    resources = [
      "*",
    ]

    actions = [
      "cloud9:CreateEnvironment*",
    ]
  }
}

resource "aws_iam_policy" "cloud9_users" {
  name        = "${var.org_name}.Base.Cloud9.Users"
  description = "${var.org_name}.Base.Cloud9.Users"
  path        = "/${var.org_name}/Base/"
  policy      = "${data.aws_iam_policy_document.cloud9_users.json}"
}

resource "aws_iam_group" "cloud9_users" {
  name = "MOIL.Cloud9.Users"
  path = "/"
}

resource "aws_iam_group" "cloud9_admins" {
  name = "MOIL.Cloud9.Admins"
  path = "/"
}

resource "aws_iam_user" "cloud9_user1" {
  name = "petermac"
}

resource "aws_iam_user" "cloud9_user2" {
  name = "mattbark"
}

resource "aws_iam_group_membership" "cloud9_users" {
  name = "cloud9_users"

  users = [
    "${aws_iam_user.cloud9_user1.name}",
    "${aws_iam_user.cloud9_user2.name}",
  ]

  group = "${aws_iam_group.cloud9_users.name}"

  depends_on = [
    "aws_iam_group.cloud9_users",
    "aws_iam_user.cloud9_user1",
    "aws_iam_user.cloud9_user2",
  ]
}

resource "aws_iam_group_membership" "cloud9_admins" {
  name = "cloud9_admins"

  users = [
    "wileyj",
  ]

  group = "${aws_iam_group.cloud9_admins.name}"

  depends_on = [
    "aws_iam_group.cloud9_admins",
  ]
}

resource "aws_iam_group_policy_attachment" "cloud9_users" {
  group      = "${aws_iam_group.cloud9_users.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCloud9User"

  depends_on = [
    "aws_iam_group.cloud9_users",
  ]
}

resource "aws_iam_group_policy_attachment" "cloud9_users_restrictions" {
  group      = "${aws_iam_group.cloud9_users.name}"
  policy_arn = "${aws_iam_policy.cloud9_users.arn}"

  depends_on = [
    "aws_iam_policy.cloud9_users",
  ]
}

resource "aws_iam_group_policy_attachment" "cloud9_admins" {
  group      = "${aws_iam_group.cloud9_admins.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCloud9Administrator"

  # policy_arn = "${aws_iam_policy.policy.arn}"
  depends_on = [
    "aws_iam_group.cloud9_admins",
  ]
}
