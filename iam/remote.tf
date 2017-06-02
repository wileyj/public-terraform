
data "template_file" "remote_base_assumerole" {
    template = "${file("datasources/iam/policies/remote/REMOTE.Base.AssumeRole.json")}"
}

resource "aws_iam_policy" "remote_base_assumerole" {
    name        = "REMOTE.Base.AssumeRole"
    description = "REMOTE.Base.AssumeRole"
    path        = "/REMOTE/Base/"
    policy      = "${data.template_file.remote_base_assumerole.rendered}"
}
output "remote_base_assumerole_policy_arn" {
    value = "${aws_iam_policy.remote_base_assumerole.arn}"
}
