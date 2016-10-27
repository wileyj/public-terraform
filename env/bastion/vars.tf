variable "name" {
  description = "VPC Name"
  default     = "Bastion"
}

variable "name_lower" {
  description = "VPC Name"
  default     = "bastion"
}

variable "cidr" {
  description = "CIDR of vpc"

  default {
    "us-west-2" = "10.254.0.0/16"
    "us-west-1" = "10.253.0.0/16"
  }
}

variable "nameserver" {
  description = "IP of VPC DNS server (cidr root +2)"

  default {
    "us-west-2" = "10.254.0.2"
    "us-west-1" = "10.253.0.2"
  }
}

variable "public_subnets" {
  description = "Cidrs of public subnets"

  default = {
    "us-west-2" = "10.254.100.0/23, 10.254.102.0/23"
    "us-west-1" = "10.253.100.0/23, 10.253.102.0/23"
  }
}

variable "private_subnets" {
  description = "Cidrs of private subnets"

  default = {
    "us-west-2" = "10.254.0.0/23, 10.254.2.0/23"
    "us-west-1" = "10.253.0.0/23, 10.253.2.0/23"
  }
}
