data "template_file" "local_base_asg" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.ASG.json")}"
}
data "template_file" "local_base_cloudfront" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Cloudfront.json")}"
}
data "template_file" "local_base_cloudwatch" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Cloudwatch.json")}"
}
data "template_file" "local_base_ec2" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.EC2.json")}"
}
data "template_file" "local_base_efs" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.EFS.json")}"
}
data "template_file" "local_base_elasticache" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Elasticache.json")}"
}
data "template_file" "local_base_kinesis" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Kinesis.json")}"
}
data "template_file" "local_base_lambda" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Lambda.json")}"
}
data "template_file" "local_base_restricted" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Restricted.json")}"
}
data "template_file" "local_base_rds" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.RDS.json")}"
}
data "template_file" "local_base_redshift" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Redshift.json")}"
}
data "template_file" "local_base_route53" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.Route53.json")}"
}
data "template_file" "local_base_s3" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.S3.json")}"
}
data "template_file" "local_base_sns" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.SNS.json")}"
}
data "template_file" "local_base_sqs" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.SQS.json")}"
}
data "template_file" "local_base_waf" {
    template = "${file("datasources/iam/policies/base/LOCAL.Base.WAF.json")}"
}
resource "aws_iam_policy" "local_base_asg" {
    name        = "${var.org_name}.Base.ASG"
    description = "${var.org_name}.Base.ASG"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_asg.rendered}"
}
output "local_base_asg_policy_arn" {
    value = "${aws_iam_policy.local_base_asg.arn}"
}

resource "aws_iam_policy" "local_base_cloudfront" {
    name        = "${var.org_name}.Base.Cloudfront"
    description = "${var.org_name}.Base.Cloudfront"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_cloudfront.rendered}"
}
output "local_base_cloudfront_policy_arn" {
    value = "${aws_iam_policy.local_base_cloudfront.arn}"
}

resource "aws_iam_policy" "local_base_cloudwatch" {
    name        = "${var.org_name}.Base.Cloudwatch"
    description = "${var.org_name}.Base.Cloudwatch"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_cloudwatch.rendered}"
}
output "local_base_cloudwatch_policy_arn" {
    value = "${aws_iam_policy.local_base_cloudwatch.arn}"
}

resource "aws_iam_policy" "local_base_ec2" {
    name        = "${var.org_name}.Base.EC2"
    description = "${var.org_name}.Base.EC2"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_ec2.rendered}"
}
output "local_base_ec2_policy_arn" {
    value = "${aws_iam_policy.local_base_ec2.arn}"
}

resource "aws_iam_policy" "local_base_efs" {
    name        = "${var.org_name}.Base.EFS"
    description = "${var.org_name}.Base.EFS"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_efs.rendered}"
}
output "local_base_efs_policy_arn" {
    value = "${aws_iam_policy.local_base_efs.arn}"
}

resource "aws_iam_policy" "local_base_elasticache" {
    name        = "${var.org_name}.Base.Elasticache"
    description = "${var.org_name}.Base.Elasticache"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_elasticache.rendered}"
}
output "local_base_elasticache_policy_arn" {
    value = "${aws_iam_policy.local_base_elasticache.arn}"
}

resource "aws_iam_policy" "local_base_kinesis" {
    name        = "${var.org_name}.Base.Kinesis"
    description = "${var.org_name}.Base.Kinesis"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_kinesis.rendered}"
}
output "local_base_kinesis_policy_arn" {
    value = "${aws_iam_policy.local_base_kinesis.arn}"
}

resource "aws_iam_policy" "local_base_lambda" {
    name        = "${var.org_name}.Base.Lambda"
    description = "${var.org_name}.Base.Lambda"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_lambda.rendered}"
}
output "local_base_lambda_policy_arn" {
    value = "${aws_iam_policy.local_base_lambda.arn}"
}

resource "aws_iam_policy" "local_base_restricted" {
    name        = "${var.org_name}.Base.Restricted"
    description = "${var.org_name}.Base.Restricted"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_restricted.rendered}"
}
output "local_base_restricted_policy_arn" {
    value = "${aws_iam_policy.local_base_restricted.arn}"
}

resource "aws_iam_policy" "local_base_rds" {
    name        = "${var.org_name}.Base.RDS"
    description = "${var.org_name}.Base.RDS"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_rds.rendered}"
}
output "local_base_rds_policy_arn" {
    value = "${aws_iam_policy.local_base_rds.arn}"
}

resource "aws_iam_policy" "local_base_redshift" {
    name        = "${var.org_name}.Base.Redshift"
    description = "${var.org_name}.Base.Redshift"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_redshift.rendered}"
}
output "local_base_redshift_policy_arn" {
    value = "${aws_iam_policy.local_base_redshift.arn}"
}

resource "aws_iam_policy" "local_base_route53" {
    name        = "${var.org_name}.Base.Route53"
    description = "${var.org_name}.Base.Route53"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_route53.rendered}"
}
output "local_base_route53_policy_arn" {
    value = "${aws_iam_policy.local_base_route53.arn}"
}

resource "aws_iam_policy" "local_base_s3" {
    name        = "${var.org_name}.Base.S3"
    description = "${var.org_name}.Base.S3"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_s3.rendered}"
}
output "local_base_s3_policy_arn" {
    value = "${aws_iam_policy.local_base_s3.arn}"
}

resource "aws_iam_policy" "local_base_sns" {
    name        = "${var.org_name}.Base.SNS"
    description = "${var.org_name}.Base.SNS"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_sns.rendered}"
}
output "local_base_sns_policy_arn" {
    value = "${aws_iam_policy.local_base_sns.arn}"
}

resource "aws_iam_policy" "local_base_sqs" {
    name        = "${var.org_name}.Base.SQS"
    description = "${var.org_name}.Base.SQS"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_sqs.rendered}"
}
output "local_base_sqs_policy_arn" {
    value = "${aws_iam_policy.local_base_sqs.arn}"
}

resource "aws_iam_policy" "local_base_waf" {
    name        = "${var.org_name}.Base.WAF"
    description = "${var.org_name}.Base.WAF"
    path        = "/${var.org_name}/Base/"
    policy      = "${data.template_file.local_base_waf.rendered}"
}
output "local_base_waf_policy_arn" {
    value = "${aws_iam_policy.local_base_waf.arn}"
}

resource "aws_iam_role" "local_base_role" {
    name = "${var.org_name}.Base"
    assume_role_policy = "${data.aws_iam_policy_document.base_trust.json}"
    path        = "/${var.org_name}/"
}

resource "aws_iam_role_policy_attachment" "local_base_ec2_policyattach" {
    role      = "${aws_iam_role.local_base_role.name}"
    policy_arn = "${aws_iam_policy.local_base_ec2.arn}"
    depends_on = [
        "aws_iam_role.local_base_role",
        "aws_iam_policy.local_base_ec2"
    ]
}
resource "aws_iam_role_policy_attachment" "local_base_s3_policyattach" {
    role      = "${aws_iam_role.local_base_role.name}"
    policy_arn = "${aws_iam_policy.local_base_s3.arn}"
    depends_on = [
        "aws_iam_role.local_base_role",
        "aws_iam_policy.local_base_s3"
    ]
}
resource "aws_iam_role_policy_attachment" "local_base_asg_policyattach" {
    role      = "${aws_iam_role.local_base_role.name}"
    policy_arn = "${aws_iam_policy.local_base_asg.arn}"
    depends_on = [
        "aws_iam_role.local_base_role",
        "aws_iam_policy.local_base_asg"
    ]
}
resource "aws_iam_role_policy_attachment" "local_base_sqs_policyattach" {
    role      = "${aws_iam_role.local_base_role.name}"
    policy_arn = "${aws_iam_policy.local_base_sqs.arn}"
    depends_on = [
        "aws_iam_role.local_base_role",
        "aws_iam_policy.local_base_sqs"
    ]
}

resource "aws_iam_role_policy_attachment" "local_base_cloudwatch_policyattach" {
    role      = "${aws_iam_role.local_base_role.name}"
    policy_arn = "${aws_iam_policy.local_base_cloudwatch.arn}"
    depends_on = [
        "aws_iam_role.local_base_role",
        "aws_iam_policy.local_base_cloudwatch"
    ]
}
