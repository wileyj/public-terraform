variable "name" {
    description = "VPC Name"
    default     = "DB"
}

variable "name_lower" {
    description = "VPC Name"
    default     = "db"
}

variable "cidr" {
    description = "CIDR of vpc"
    default {
        "us-east-1" = "10.95.0.0/16"
        "us-west-2" = "10.195.0.0/16"
    }
}

variable "nameserver" {
    description = "IP of VPC DNS server (cidr root +2)"
    default {
        "us-east-1" = "10.95.0.2"
        "us-west-2" = "10.195.0.2"
    }
}

variable "public_subnets" {
    description = "Cidrs of public subnets"
    default = {
        "us-east-1" = "10.95.100.0/23,10.95.102.0/23"
        "us-west-2" = "10.195.100.0/23,10.195.102.0/23"
    }
}


variable "private_subnets" {
    description = "Cidrs of private subnets"
    default = {
        "us-east-1" = "10.95.0.0/23,10.95.2.0/23"
        "us-west-2" = "10.195.0.0/23,10.195.2.0/23"
    }
}


variable "environment" {
    default     = "db"
    description = "Environment Name"
}

variable "buckets" {
    description = "Bucket Names"
    default = {
        "primary" = [
            "local-db-primary-001"
        ]
        "secondary" = [
            "local-db-secondary-001"
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
