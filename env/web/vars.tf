variable "name" {
    description = "VPC Name"
    default     = "Web"
}

variable "name_lower" {
    description = "VPC Name"
    default     = "web"
}

variable "cidr" {
    description = "CIDR of vpc"
    default {
        "us-east-1" = "10.75.0.0/16"
        "us-west-2" = "10.175.0.0/16"
    }
}

variable "nameserver" {
    description = "IP of VPC DNS server (cidr root +2)"
    default {
        "us-east-1" = "10.75.0.2"
        "us-west-2" = "10.175.0.2"
    }
}

variable "public_subnets" {
    description = "Cidrs of public subnets"
    default = {
        "us-east-1" = "10.75.100.0/23,10.75.102.0/23"
        "us-west-2" = "10.175.100.0/23,10.175.102.0/23"
    }
}


variable "private_subnets" {
    description = "Cidrs of private subnets"
    default = {
        "us-east-1" = "10.75.0.0/23,10.75.2.0/23"
        "us-west-2" = "10.175.0.0/23,10.175.2.0/23"
    }
}

variable "environment" {
    default     = "web"
    description = "Environment Name"
}

variable "buckets" {
    description = "Bucket Names"
    default = {
        "primary" = [
            "local-web-primary-001"
        ]
        "secondary" = [
            "local-web-secondary-001"
        ]
    }
}

variable "ecs_env" {
    description = "ECS Cluster Environments"
    default = {
        "primary" = [
            "production",
            "staging"
        ],
        "secondary" = [
            "production",
            "staging"
        ]
    }
}

variable "ecs_instance_profile" {
    default = ""
}
