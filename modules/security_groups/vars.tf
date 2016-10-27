variable "protocol" {
  description = "Traffic type (tcp/udp)"

  // TCP: 6

  // UDP: 17

  // ICMP: 1
}

variable "name" {
  description = "Name of rule"
}

variable "vpc" {
  description = "VPC where sg is placed"
}

variable "source_address" {
  description = "Originating IP"
}

variable "to_port" {
  description = "Port to open from"
}

variable "from_port" {
  description = "Port to open to"
}

variable "description" {
  description = "SG Description"
}
