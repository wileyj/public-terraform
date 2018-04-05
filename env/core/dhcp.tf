resource "aws_vpc_dhcp_options" "default" {
  domain_name         = "${var.name_lower}.${var.domain}"
  domain_name_servers = ["AmazonProvidedDNS"]

  /*domain_name_servers = [ "${lookup(var.nameserver, var.region["${var.buildenv}"])}", "AmazonProvidedDNS" ]*/
  tags {
    Name        = "${var.name_lower}.${var.domain}"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Stage       = ""
    Region      = "${var.region["${var.buildenv}"]}"
    Application = "shared"
    Role        = "networking"
    Service     = "vpc"
    Category    = "dhcp.options"
  }

  lifecycle {
    create_before_destroy = true

    /*prevent_destroy = true*/
  }
}

# module "sns_core_default_policy" {
#   domain_name = "${var.name_lower}.${var.domain}"
#   policy_id       = "${var.org_name}-${var.name}-SNS"
#   sid             = "MOIL-Core-default"
#   identifier      = "arn:aws:iam::${var.account_id}:root"
#   resources       = ["${aws_sns_topic.default.arn}"]
#   condition_name  = "AWS:SourceOwner"
#   condition_value = ["${var.account_id}"]
#   actions         = ["SNS:GetTopicAttributes", "SNS:SetTopicAttributes", "SNS:AddPermission", "SNS:RemovePermission", "SNS:DeleteTopic", "SNS:Subscribe", "SNS:ListSubscriptionsByTopic", "SNS:Publish", "SNS:Receive"]
# }

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id          = "${aws_vpc.default.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"

  depends_on = [
    "aws_vpc_dhcp_options.default",
    "aws_vpc.default",
  ]
}
