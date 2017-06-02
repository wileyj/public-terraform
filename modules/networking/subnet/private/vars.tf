variable "id" {
    description = "VPC to build resource in"
}

variable "name" {
    description = "VPC Name"
}

variable "subnets" {
    description = "List of subnet cidr's"
    //  type        = "map"
}

variable "allocate_public_ip" {
    description = "Launch Hosts in subnet with public IP"
    default     = "false"
}

variable "environment" {
    description = "Environment Name"
}
