variable "vpc_id" {
  description = "VPC ID"
  default     = ""
}

variable "vpc_name" {
  description = "VPC Name"
  default     = ""
}

variable "domain" {
  description = "Domain"
  default     = ""
}

variable "owner" {
  description = "owner"
  default     = ""
}

variable "environment" {
  description = "environemnt"
  default     = ""
}

variable "region" {
  description = "region"
  default     = ""
}

variable "ecs_cluster" {
  description = "region"
  default     = ""
}

variable "ecs_base_role" {
  description = "ecs_base_role"
  default     = ""
}

variable "org_name" {
  description = "org_name"
  default     = ""
}

variable "cidr" {
  description = "cidr"
  default     = ""
}

variable "public_subnets" {
  description = "public subnet array"
  default     = []
}

variable "dns_zone" {
  description = "dns zone id"
  default     = ""
}

variable "public_dns_zone" {
  description = "public dns zone id"
  default     = ""
}

variable "nat_gatewaays" {
  description = "nat gateways for sg"
  default     = ""
}
