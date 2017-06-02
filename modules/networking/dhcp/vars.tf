variable "name" {
    description = "vpc name"
}

variable "vpc_domain" {
    description = "Domain of DHCP option set"
}

variable "nameserver" {
    description = "DNS server to use in DHCP option set"
}

variable "environment" {
    description = "Environment Name"
}
