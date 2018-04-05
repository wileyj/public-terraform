resource "aws_alb_listener" "cryptotracker_elasticsearch" {
  load_balancer_arn = "${aws_alb.cryptotracker.arn}"
  port              = 9200
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.cryptotracker_elasticsearch.arn}"
    type             = "forward"
  }

  depends_on = [
    "aws_alb_target_group.cryptotracker_elasticsearch",
  ]
}

resource "aws_alb_listener" "cryptotracker_kibana" {
  load_balancer_arn = "${aws_alb.cryptotracker.arn}"
  port              = 5601
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.cryptotracker_kibana.arn}"
    type             = "forward"
  }

  depends_on = [
    "aws_alb_target_group.cryptotracker_kibana",
  ]
}

resource "aws_alb_listener_rule" "cryptotracker_elasticsearch" {
  listener_arn = "${aws_alb_listener.cryptotracker_elasticsearch.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.cryptotracker_elasticsearch.arn}"
  }

  condition {
    field = "path-pattern"

    values = [
      "*",
    ]
  }

  depends_on = [
    "aws_alb_listener.cryptotracker_elasticsearch",
    "aws_alb_target_group.cryptotracker_elasticsearch",
  ]
}

resource "aws_alb_listener_rule" "cryptotracker_kibana" {
  listener_arn = "${aws_alb_listener.cryptotracker_kibana.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.cryptotracker_kibana.arn}"
  }

  condition {
    field = "path-pattern"

    values = [
      "*",
    ]
  }

  depends_on = [
    "aws_alb_listener.cryptotracker_kibana",
    "aws_alb_target_group.cryptotracker_kibana",
  ]
}

resource "aws_alb_target_group" "cryptotracker_elasticsearch" {
  name                 = "cryptotracker-9200"
  port                 = "9200"
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = 10

  tags {
    Name        = "cryptotracker-9200"
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
    path                = "/_cat/health"
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_alb_target_group" "cryptotracker_kibana" {
  name                 = "cryptotracker-5601"
  port                 = "5601"
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = 10

  tags {
    Name        = "cryptotracker-5601"
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
    path                = "/status"
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_alb" "cryptotracker" {
  name                       = "cryptotracker"
  internal                   = false
  enable_deletion_protection = false
  subnets                    = ["${var.public_subnets}"]

  security_groups = [
    "${aws_security_group.cryptotracker.id}",
    "${aws_security_group.cryptotracker_external.id}",
  ]

  tags {
    Name        = "cryptotracker"
    Department  = "${var.owner}"
    Environment = "${var.environment}"
    Region      = "${var.region}"
    Application = "shared"
    Role        = "alb"
    Service     = "ec2"
    Category    = "load.balancer"
  }

  depends_on = [
    "aws_security_group.cryptotracker",
    "aws_security_group_rule.allow_elasticsearch_9200",
    "aws_security_group_rule.allow_elasticsearch_9300",
    "aws_security_group_rule.allow_kibana_5601",
  ]
}

resource "aws_route53_record" "elasticsearch" {
  zone_id        = "${var.dns_zone}"
  name           = "es"
  type           = "CNAME"
  ttl            = "5"
  set_identifier = "es"

  weighted_routing_policy {
    weight = 10
  }

  records = [
    "${aws_alb.cryptotracker.dns_name}",
  ]

  depends_on = [
    "aws_alb.cryptotracker",
  ]
}

resource "aws_route53_record" "kibana" {
  zone_id        = "${var.dns_zone}"
  name           = "kibana"
  type           = "CNAME"
  ttl            = "5"
  set_identifier = "es"

  weighted_routing_policy {
    weight = 10
  }

  records = [
    "${aws_alb.cryptotracker.dns_name}",
  ]

  depends_on = [
    "aws_alb.cryptotracker",
  ]
}

resource "aws_route53_record" "cryptotracker" {
  zone_id        = "${var.public_dns_zone}"
  name           = "crypto"
  type           = "CNAME"
  ttl            = "5"
  set_identifier = "crypto"

  weighted_routing_policy {
    weight = 10
  }

  records = [
    "${aws_alb.cryptotracker.dns_name}",
  ]

  depends_on = [
    "aws_alb.cryptotracker",
  ]
}
