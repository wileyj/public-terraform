variable "name" {
  description = "KMS Key Name"
}

variable "group" {
  description = "KMS Group Name"
}

variable "description" {
  description = "KMS Key description"
}

variable "environment" {
  default     = "dev"
  description = "Environment (dev, stg, prd)"
}
