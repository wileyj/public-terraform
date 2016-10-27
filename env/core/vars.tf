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
    "us-west-2" = "10.225.0.0/16"
    "us-west-1" = "10.226.0.0/16"
  }
}

variable "nameserver" {
  description = "IP of VPC DNS server (cidr root +2)"

  default {
    "us-west-2" = "10.225.0.2"
    "us-west-1" = "10.226.0.2"
  }
}

variable "public_subnets" {
  description = "Cidrs of public subnets"

  default = {
    "us-west-2" = "10.225.100.0/23, 10.225.102.0/23"
    "us-west-1" = "10.226.100.0/23, 10.226.102.0/23"
  }
}

variable "private_subnets" {
  description = "Cidrs of private subnets"

  default = {
    "us-west-2" = "10.225.0.0/23, 10.225.2.0/23"
    "us-west-1" = "10.226.0.0/23, 10.226.2.0/23"
  }
}
