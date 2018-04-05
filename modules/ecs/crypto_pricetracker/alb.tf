resource "aws_alb_listener" "crypto_pricetracker" {
  load_balancer_arn = "${aws_alb.crypto_pricetracker.arn}"
  port              = 5000
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.crypto_pricetracker.arn}"
    type             = "forward"
  }

  depends_on = [
    "aws_alb_target_group.crypto_pricetracker",
  ]
}

resource "aws_alb_listener_rule" "crypto_pricetracker" {
  listener_arn = "${aws_alb_listener.crypto_pricetracker.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.crypto_pricetracker.arn}"
  }

  condition {
    field = "path-pattern"

    values = [
      "*",
    ]
  }

  depends_on = [
    "aws_alb_listener.crypto_pricetracker",
    "aws_alb_target_group.crypto_pricetracker",
  ]
}

resource "aws_alb_target_group" "crypto_pricetracker" {
  name                 = "crypto-pricetracker-5000"
  port                 = "5000"
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = 10

  tags {
    Name        = "crypto-pricetracker-5000"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Application = "shared"
    Role        = "alb"
    Service     = "ec2"
    Category    = "target.group"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_alb" "crypto_pricetracker" {
  name                       = "crypto-pricetracker"
  internal                   = false
  enable_deletion_protection = false
  subnets                    = ["${var.public_subnets}"]

  security_groups = [
    "${aws_security_group.crypto_pricetracker.id}",
    "${aws_security_group.crypto_pricetracker_external.id}",
  ]

  tags {
    Name        = "crypto-pricetracker"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Application = "shared"
    Role        = "alb"
    Service     = "ec2"
    Category    = "load.balancer"
  }

  depends_on = [
    "aws_security_group.crypto_pricetracker",
    "aws_security_group_rule.allow_crypto_pricetracker_5000",
  ]
}

resource "aws_route53_record" "crypto_pricetracker" {
  zone_id        = "${var.dns_zone}"
  name           = "cpn"
  type           = "CNAME"
  ttl            = "5"
  set_identifier = "es"

  weighted_routing_policy {
    weight = 10
  }

  records = [
    "${aws_alb.crypto_pricetracker.dns_name}",
  ]

  depends_on = [
    "aws_alb.crypto_pricetracker",
  ]
}

resource "aws_route53_record" "crypto_pricetracker_public" {
  zone_id        = "${var.public_dns_zone}"
  name           = "cpt"
  type           = "CNAME"
  ttl            = "5"
  set_identifier = "crypto"

  weighted_routing_policy {
    weight = 10
  }

  records = [
    "${aws_alb.crypto_pricetracker.dns_name}",
  ]

  depends_on = [
    "aws_alb.crypto_pricetracker",
  ]
}
