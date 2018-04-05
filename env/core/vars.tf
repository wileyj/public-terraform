variable "name" {
  description = "VPC Name"
  default     = "Core"
}

variable "name_lower" {
  description = "VPC Name"
  default     = "core"
}

variable "cidr" {
  description = "CIDR of core vpc"

  default {
    "us-east-1" = "10.55.0.0/16"
    "us-west-2" = "10.155.0.0/16"
  }
}

variable "nameserver" {
  description = "IP of VPC DNS server (cidr root +2)"

  default {
    "us-east-1" = "10.55.0.2"
    "us-west-2" = "10.155.0.2"
  }
}

/*
this is the least aggravating option. one 1 change has to be made to add additional networks.
the alternative requires multiple edits of multiple files.no good.
*/
variable "public_subnets" {
  description = "Cidrs of public subnets"

  default = {
    "us-east-1" = "10.55.0.0/23,10.55.2.0/23"
    "us-west-2" = "10.155.100.0/23,10.155.102.0/23"
  }
}

variable "private_subnets" {
  description = "Cidrs of private subnets"

  default = {
    "us-east-1" = "10.55.10.0/23,10.55.11.0/23"
    "us-west-2" = "10.155.0.0/23,10.155.2.0/23"
  }
}

variable "ecs_subnets" {
  description = "Cidrs of private subnets"

  default = {
    "us-east-1" = "10.55.10.0/24,10.55.11.0/24"
    "us-west-2" = "10.155.10.0/24,10.155.11.0/24"
  }
}

variable "environment" {
  default     = "core"
  description = "Environment Name"
}

variable "buckets" {
  description = "Bucket Names"

  default = {
    "primary" = [
      "moil-core-primary-001",
    ]

    "secondary" = [
      "moil-core-secondary-001",
    ]
  }
}

variable "ecs_env" {
  description = "ECS Cluster Environments"

  default = {
    "primary" = [
      "production",
    ]

    "secondary" = [
      "production",
    ]
  }
}

variable "ecs_instance_profile" {
  default = ""
}

variable "ecs_base_role" {
  default = ""
}

variable ecs_base_policy {
  default = ""
}

variable "k8s_env" {
  description = "K8S Cluster Environments"

  default = {
    "primary" = [
      "production",
    ]

    "secondary" = [
      "production",
    ]
  }
}

variable "k8s_instance_profile" {
  default = ""
}

variable "vault_env" {
  description = "K8S Cluster Environments"

  default = {
    "primary" = [
      "production",
    ]
  }
}

variable "vault_instance_profile" {
  default = ""
}

variable "consul_env" {
  description = "K8S Cluster Environments"

  default = {
    "primary" = [
      "production",
    ]
  }
}

variable "consul_instance_profile" {
  default = ""
}

variable "visibility_timeout_seconds" {
  description = "the timeout in seconds of visibility of the message"
  default     = 30
}

variable "delay_seconds" {
  description = "delay in displaying message"
  default     = "0"
}

variable "max_message_size" {
  description = "max size of the message default to 256KB"
  default     = "262144"
}

variable "message_retention_seconds" {
  description = "seconds of retention of the message default to 4 days"
  default     = "345600"
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
  default     = "20"
}

variable "dead_letter_queue" {
  description = "The dead letter queue to use for undeliverable messages"
  default     = ""
}

variable "max_receive_count" {
  description = "Maximum receive count"
  default     = "5"
}

variable "fifo_queue" {
  description = "Configure the queue to be a FIFO queue"
  default     = "false"
}
