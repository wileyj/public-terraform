variable "policy_name" {
  description = "Policy Name"
}

variable "path" {
  description = "IAM PAth"
  default     = "/"
}

variable "policy" {}

variable "tags" {
  description = "Map of tags"
  type        = "map"
  default     = ""
}
