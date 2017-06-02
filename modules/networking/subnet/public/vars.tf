variable "id" {
  description = "VPC to build resource in"
}

variable "name" {
  description = "VPC Name"
}

variable "gateway_id" {
    description = "VPC Internet Gateway"
}

variable "subnets" {
  description = "List of subnet cidr's"
}

variable "allocate_public_ip" {
  description = "Launch Hosts in subnet with public IP"
  default     = "false"
}

variable "environment" {
    description = "Environment Name"
}
