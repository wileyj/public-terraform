variable "name" {
  description = "VPC Name"
  default     = "App"
}

variable "name_lower" {
  description = "VPC Name"
  default     = "app"
}

variable "cidr" {
  description = "CIDR of vpc"

  default {
    "us-east-1" = "10.85.0.0/16"
    "us-west-2" = "10.185.0.0/16"
  }
}

variable "nameserver" {
  description = "IP of VPC DNS server (cidr root +2)"

  default {
    "us-east-1" = "10.85.0.2"
    "us-west-2" = "10.185.0.2"
  }
}

variable "public_subnets" {
  description = "Cidrs of public subnets"

  default = {
    "us-east-1" = "10.85.100.0/23,10.85.102.0/23"
    "us-west-2" = "10.185.100.0/23,10.185.102.0/23"
  }
}

variable "private_subnets" {
  description = "Cidrs of private subnets"

  default = {
    "us-east-1" = "10.85.0.0/23,10.85.2.0/23"
    "us-west-2" = "10.185.0.0/23,10.185.2.0/23"
  }
}

variable "environment" {
  default     = "app"
  description = "Environment Name"
}

variable "buckets" {
  description = "Bucket Names"

  default = {
    "primary" = [
      "moil-app-primary-001",
    ]

    "secondary" = [
      "moil-app-secondary-001",
    ]
  }
}

variable "ecs_env" {
  description = "ECS Cluster Environments"

  default = {
    "primary" = [
      "production",
      "staging",
    ]

    "secondary" = [
      "production",
      "staging",
    ]
  }
}

variable "ecs_instance_profile" {
  default = ""
}
