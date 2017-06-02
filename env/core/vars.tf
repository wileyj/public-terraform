variable "name" {
    description = "VPC Name"
    default     = "Core"
}

variable "name_lower" {
    description = "VPC Name"
    default     = "core"
}

variable "cidr" {
    description = "CIDR of core vpc"
    default {
        "us-east-1" = "10.55.0.0/16"
        "us-west-2" = "10.155.0.0/16"
    }
}

variable "nameserver" {
    description = "IP of VPC DNS server (cidr root +2)"
    default {
        "us-east-1" = "10.55.0.2"
        "us-west-2" = "10.155.0.2"
    }
}

/*
this is the least aggravating option. one 1 change has to be made to add additional networks.
the alternative requires multiple edits of multiple files.no good.
*/
variable "public_subnets" {
    description = "Cidrs of public subnets"
    default = {
        "us-east-1" = "10.55.100.0/23,10.55.102.0/23"
        "us-west-2" = "10.155.100.0/23,10.155.102.0/23"
    }
}


variable "private_subnets" {
    description = "Cidrs of private subnets"
    default = {
        "us-east-1" = "10.55.0.0/23,10.55.2.0/23"
        "us-west-2" = "10.155.0.0/23,10.155.2.0/23"
    }
}

variable "environment" {
    default     = "core"
    description = "Environment Name"
}

variable "buckets" {
    description = "Bucket Names"
    default = {
        "primary" = [
            "local-core-primary-001"
        ]
        "secondary" = [
            "local-core-secondary-001"
        ]
    }
}

variable "ecs_env" {
    description = "ECS Cluster Environments"
    default = {
        "primary" = [
            "production"
        ],
        "secondary" = [
            "production"
        ]
    }
}

variable "ecs_instance_profile" {
    default = ""
}
