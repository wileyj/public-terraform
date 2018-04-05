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

variable "nodejs_docker_image" {
  description = ""
  default     = ""
}

variable "nodejs_port" {
  description = ""
  default     = ""
}

variable "nodejs_mem" {
  description = "nodejs memory"
  default     = ""
}

variable "nodejs_cpu" {
  description = "nodejs cpu"
  default     = ""
}

variable "redis_docker_image" {
  description = ""
  default     = ""
}

variable "redis_mem" {
  description = "redis memory"
  default     = ""
}

variable "redis_cpu" {
  description = "redis cpu"
  default     = ""
}

variable "redis_source_volume" {
  description = ""
  default     = ""
}

variable "redis_container_path" {
  description = ""
  default     = ""
}
