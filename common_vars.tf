variable "buildenv" {
  description = "Env to build"
  default     = "primary"
}

variable "account_id" {
  description = "Account ID"
  default     = "307234534562"
}

variable "org_name_long" {
  description = "Org Name Long"
  default     = "Moil"
}

variable "org_name" {
  description = "Org Name"
  default     = "MOIL"
}

variable "org_name_short" {
  description = "Org name short"
  default     = "MOIL"
}

variable "org_name_short_lc" {
  description = "Org name short lc"
  default     = "moil"
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
    "us-east-1" = "us-east-1a,us-east-1d"
    "us-west-2" = "us-west-2a,us-west-2c"
  }
}

variable "azones" {
  description = "VPC Availability Zone"
  type        = "map"

  default = {
    "secondary" = [
      "us-east-1a",
      "us-east-1d",
    ]

    "primary" = [
      "us-west-2a",
      "us-west-2c",
    ]
  }
}

variable "bastion_cidr" {
  description = "Bastion CIDR"
  default     = ""
}

variable "domain" {
  description = "Base org domain"
  default     = "moil.io"
}

variable "coreos_use1_hvm_ami" {
  type = "map"

  default = {
    # alpha  = "ami-b1620fd1"
    # beta   = "ami-234c2c43"
    # stable = "ami-f4d4b694"
    stable = "ami-ea0a9392"

    alpha = "ami-54029b2c"
    beta  = "	ami-db0b92a3"
  }
}

variable "docker_auth_key" {
  default = ""
}

variable "docker_auth_id" {
  default = ""
}

variable "quay_auth_key" {
  default = ""
}

variable "quay_auth_id" {
  default = ""
}

variable "registrator_image" {
  default = "gliderlabs/registrator:latest"
}

variable "ecs_ec2" {
  default = "t2.medium"
}

variable "ec2_key" {
  default = "Base"
}
