variable "name" {
    description = "DNS Zone Name"
}
variable "environment" {
    description = "Environment Name"
}

variable "zone_id" {
    description = "Route53 Zone ID"
}

variable "ttl" {
    description = "Route53 Record TTL"
    default = 300
}

variable "records" {
    description = "Route53 DNS Records"
}

variable "type" {
    description = "Route53 DNS Record Type"
}

variable "weight" {
    description = "Weighted Routing Value"
    default = 1
}
