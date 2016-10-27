variable "buildenv" {
  description = "Env to build"
  default     = "primary"
}

variable "org_name_long" {
  description = "Org Name Long"
  default     = "Makerbot"
}

variable "org_name_short" {
  description = "Org name short"
  default     = "MBOT"
}

variable "org_name_short_lc" {
  description = "Org name short lc"
  default     = "mbot"
}

variable "owner" {
  description = "Default Asset owner"
  default     = "Ops"
}

variable "region" {
  description = "AWS Region"

  default {
    "primary"   = "us-west-2"
    "secondary" = "us-west-1"
  }
}

variable "azs" {
  description = "VPC Availability Zones"
  type        = "map"

  default = {
    "us-west-2" = "us-west-2a, us-west-2b"
    "us-west-1" = "us-west-1b, us-west-1c"
  }
}

variable "domain" {
  description = "Base org domain"
  default     = "makerbot.net"
}
