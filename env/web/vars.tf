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
		"us-west-2" = "10.0.0.0/16",
		"us-west-1" = "10.1.0.0/16"
	}
}

variable "nameserver" {
	description = "IP of VPC DNS server (cidr root +2)"
	default {
		"us-west-2" = "10.0.0.2",
		"us-west-1" = "10.1.0.2"
	}
}

variable "public_subnets" {
	description = "Cidrs of public subnets"
	default = {
		"us-west-2" = "10.0.100.0/23, 10.0.102.0/23",
		"us-west-1" = "10.1.100.0/23, 10.1.102.0/23"
	}
}

variable "private_subnets" {
	description = "Cidrs of private subnets"
	default = {
		"us-west-2" = "10.0.0.0/23, 10.0.2.0/23",
		"us-west-1" = "10.1.0.0/23, 10.1.2.0/23"
	}
}