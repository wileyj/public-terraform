variable "buildenv" {
    description = "Env to build"
    default     = "primary"
}

variable "org_name_long" {
    description = "Org Name Long"
    default     = "Local"
}

variable "org_name" {
    description = "Org Name"
    default     = "LOCAL"
}

variable "org_name_short" {
    description = "Org name short"
    default     = "LOCAL"
}

variable "org_name_short_lc" {
    description = "Org name short lc"
    default     = "local"
}

variable "owner" {
    description = "Default Asset owner"
    default     = "ops"
}

variable "region" {
    description = "AWS Region"
    default {
        "primary"   = "us-west-2"
        "secondary" = "us-east-1"
    }
}

variable "azs" {
    description = "VPC Availability Zones"
    type        = "map"
    default = {
        "us-east-1" = "us-east-1a,us-east-1d",
        "us-west-2" = "us-west-2a,us-west-2b"
    }
}


variable "azones" {
    description = "VPC Availability Zone"
    type        = "map"
    default = {
        "primary" = [
            "us-east-1a",
            "us-east-1d"
        ]
        "secondary" = [
            "us-west-2a",
            "us-west-2d"
        ]
    }
}

variable "bastion_cidr" {
    description = "Bastion CIDR"
    default = ""
}

variable "domain" {
    description = "Base org domain"
    default     = "local.com"
}

variable "coreos_use1_hvm_ami" {
    type = "map"
    default = {
        alpha = "ami-2cb6d33a"
        beta  = "ami-74f46e62"
        stable = "ami-ad593cbb"
    }
}

variable "docker_auth_key" {
    default = "<docker_auth_key>"
}

variable "docker_auth_id" {
    default = "<docker_auth_id>"
}

variable "quay_auth_key" {
    default = "<quay_auth_key>"
}

variable "quay_auth_id" {
    default = ""
}


variable "registrator_image" {
    default = "gliderlabs/registrator:latest"
}

variable "ecs_ec2" {
    default = "t2.micro"
}

variable "ec2_key" {
    default = "Base"
}
