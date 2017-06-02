data "aws_iam_policy_document" "ec2_trust" {
    statement {
        sid  = "EC2TrustAssumeRole"
        effect  = "Allow"
        principals {
            type = "Service"
            identifiers = [
                "ec2.amazonaws.com"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}


data "aws_iam_policy_document" "ecs_trust" {
    statement {
        sid  = "ECSTrustAssumeRole"
        effect  = "Allow"
        principals {
            type = "Service"
            identifiers = [
                "ecs-tasks.amazonaws.com"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}

data "aws_iam_policy_document" "base_trust" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = [
                "ec2.amazonaws.com",
                "ecs-tasks.amazonaws.com"
            ]
        }
    }
}
