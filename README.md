### refactor of terraform using modular design principles

```
terraform plan --target=module.iam.aws_iam_policy.moil_base_asg
terraform plan --target=module.global
terraform plan --target=aws_vpc_peering_connection.core_bastion

terraform plan --target=module.env_core
terraform plan --target=module.core.private_subnet
terraform import module.iam.aws_iam_policy.remote_base_assumerole arn:aws:iam::<secondary_account_id>:policy/REMOTE.Base.AssumeRole
terraform import module.iam.aws_iam_policy.moil_base_asg arn:aws:iam::617275767683:policy/MOIL.Base.ASG
terraform import module.iam.aws_iam_policy.moil_base_cloudfront arn:aws:iam::617275767683:policy/MOIL.Base.Cloudfront
terraform import module.iam.aws_iam_policy.moil_base_cloudwatch arn:aws:iam::617275767683:policy/MOIL.Base.Cloudwatch
terraform import module.iam.aws_iam_policy.moil_base_ec2 arn:aws:iam::617275767683:policy/MOIL.Base.EC2
terraform import module.iam.aws_iam_policy.moil_base_efs arn:aws:iam::617275767683:policy/MOIL.Base.EFS
terraform import module.iam.aws_iam_policy.moil_base_elasticache arn:aws:iam::617275767683:policy/MOIL.Base.Elasticache
terraform import module.iam.aws_iam_policy.moil_base_kinesis arn:aws:iam::617275767683:policy/MOIL.Base.Kinesis
terraform import module.iam.aws_iam_policy.moil_base_lambda arn:aws:iam::617275767683:policy/MOIL.Base.Lambda
terraform import module.iam.aws_iam_policy.moil_base_rds arn:aws:iam::617275767683:policy/MOIL.Base.RDS
terraform import module.iam.aws_iam_policy.moil_base_redshift arn:aws:iam::617275767683:policy/MOIL.Base.Redshift
terraform import module.iam.aws_iam_policy.moil_base_restricted arn:aws:iam::617275767683:policy/MOIL.Base.Restricted
terraform import module.iam.aws_iam_policy.moil_base_route53 arn:aws:iam::617275767683:policy/MOIL.Base.Route53
terraform import module.iam.aws_iam_policy.moil_base_s3 arn:aws:iam::617275767683:policy/MOIL.Base.S3
terraform import module.iam.aws_iam_policy.moil_base_sns arn:aws:iam::617275767683:policy/MOIL.Base.SNS
terraform import module.iam.aws_iam_policy.moil_base_waf arn:aws:iam::617275767683:policy/MOIL.Base.WAF
terraform import module.iam.aws_iam_policy.ops_snapshot arn:aws:iam::617275767683:policy/MOIL.Base.ops.snapshot

```


env/<env>/asg.tf - might be better to move things around so that a single file containing all of the elements necessary to launch a cluster are in one location. i.e. ecs, launch config, template, asg are all in a file ecs_MOIL.tf, and another for ecs_<app>.tf etc.
makes each env less ephemeral, but could reduce work to edit/add more asg's to ecs in the future.
