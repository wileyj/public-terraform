variable "org_name_long" {
	description = "Org Name Long"
	default = "Makerbot"
}
variable "org_name_short" {
	description = "Org name short"
	default = "MBOT"
}
variable "org_name_short_lc" {
	description = "Org name short lc"
	default = "mbot"
}

variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "domain" {
	description = "Base org domain"
	default = "makerbot.net"
}
