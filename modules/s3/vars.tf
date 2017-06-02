variable "buckets" {
    description = "List of buckets"
     type        = "list"
}

variable "environment" {
    description = "Environment Name"
}

variable "versioning" {
    description = "s3 object versioning"
}

variable "acl" {
    description = "acl to use"
}
