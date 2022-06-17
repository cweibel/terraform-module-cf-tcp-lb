variable subnet_ids            {}  # The AWS Subnet Id to place the lb into
variable resource_tags         {}  # AWS tags to apply to resources
variable vpc_id                {}  # The VPC Id
variable tcp_domain            {}  # url used for tcp routing default domain
variable route53_zone_id       {}  # Route53 zone id
variable private_cidrs         {}  # CIDR ranges of all non-public ipv4 addresses (required)
variable security_groups       {}  # Array of security groups to use
variable internal_lb           { default = true } # Determine whether the load balancer is internal-only facing

variable enable_route_53       { default = 1 }  # Disable if using CloudFlare or other DNS


resource "aws_security_group" "cf_tcp_lb_security_group" {
  name        = "cf-tcp-lb-security-group"
  description = "CF TCP"
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks = var.private_cidrs
    protocol    = "tcp"
    from_port   = 40000
    to_port     = 40100
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_cidrs
  }

  tags = merge({Name = "cf-tcp-lb-security-group"}, var.resource_tags)

  lifecycle {
    ignore_changes = [name]
  }
}



resource "aws_security_group" "cf_tcp_lb_internal_security_group" {
  name        = "cf-tcp-lb-internal-security-group"
  description = "CF TCP Internal"
  vpc_id      = var.vpc_id

  ingress {
    security_groups = ["${aws_security_group.cf_tcp_lb_security_group.id}"]
    protocol        = "tcp"
    from_port       = 40000
    to_port         = 40100
  }

  ingress {
    security_groups = ["${aws_security_group.cf_tcp_lb_security_group.id}"]
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.private_cidrs
  }

  tags = merge({Name = "cf-tcp-lb-internal-security-group"}, var.resource_tags)


  lifecycle {
    ignore_changes = [name]
  }
}


resource "aws_elb" "cf_tcp_lb" {
  name                      = "cf-tcp-lb"
  cross_zone_load_balancing = true
  internal = var.internal_lb

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 5
    target              = "TCP:80"
    timeout             = 3
  }


  security_groups = [
                      aws_security_group.cf_tcp_lb_security_group.id,
                      var.security_groups
                    ]
  subnets         = var.subnet_ids


  tags = merge({Name = "cf-tcp-lb"}, var.resource_tags)


# Run the `listeners.py` script to generate large port ranges for the listeners

  listener {
    instance_port     = 40000
    instance_protocol = "tcp"
    lb_port           = 40000
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40001
    instance_protocol = "tcp"
    lb_port           = 40001
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40002
    instance_protocol = "tcp"
    lb_port           = 40002
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40003
    instance_protocol = "tcp"
    lb_port           = 40003
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40004
    instance_protocol = "tcp"
    lb_port           = 40004
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40005
    instance_protocol = "tcp"
    lb_port           = 40005
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40006
    instance_protocol = "tcp"
    lb_port           = 40006
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40007
    instance_protocol = "tcp"
    lb_port           = 40007
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40008
    instance_protocol = "tcp"
    lb_port           = 40008
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40009
    instance_protocol = "tcp"
    lb_port           = 40009
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40010
    instance_protocol = "tcp"
    lb_port           = 40010
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40011
    instance_protocol = "tcp"
    lb_port           = 40011
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40012
    instance_protocol = "tcp"
    lb_port           = 40012
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40013
    instance_protocol = "tcp"
    lb_port           = 40013
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40014
    instance_protocol = "tcp"
    lb_port           = 40014
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40015
    instance_protocol = "tcp"
    lb_port           = 40015
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40016
    instance_protocol = "tcp"
    lb_port           = 40016
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40017
    instance_protocol = "tcp"
    lb_port           = 40017
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40018
    instance_protocol = "tcp"
    lb_port           = 40018
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40019
    instance_protocol = "tcp"
    lb_port           = 40019
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40020
    instance_protocol = "tcp"
    lb_port           = 40020
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40021
    instance_protocol = "tcp"
    lb_port           = 40021
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40022
    instance_protocol = "tcp"
    lb_port           = 40022
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40023
    instance_protocol = "tcp"
    lb_port           = 40023
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40024
    instance_protocol = "tcp"
    lb_port           = 40024
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40025
    instance_protocol = "tcp"
    lb_port           = 40025
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40026
    instance_protocol = "tcp"
    lb_port           = 40026
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40027
    instance_protocol = "tcp"
    lb_port           = 40027
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40028
    instance_protocol = "tcp"
    lb_port           = 40028
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40029
    instance_protocol = "tcp"
    lb_port           = 40029
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40030
    instance_protocol = "tcp"
    lb_port           = 40030
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40031
    instance_protocol = "tcp"
    lb_port           = 40031
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40032
    instance_protocol = "tcp"
    lb_port           = 40032
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40033
    instance_protocol = "tcp"
    lb_port           = 40033
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40034
    instance_protocol = "tcp"
    lb_port           = 40034
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40035
    instance_protocol = "tcp"
    lb_port           = 40035
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40036
    instance_protocol = "tcp"
    lb_port           = 40036
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40037
    instance_protocol = "tcp"
    lb_port           = 40037
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40038
    instance_protocol = "tcp"
    lb_port           = 40038
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40039
    instance_protocol = "tcp"
    lb_port           = 40039
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40040
    instance_protocol = "tcp"
    lb_port           = 40040
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40041
    instance_protocol = "tcp"
    lb_port           = 40041
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40042
    instance_protocol = "tcp"
    lb_port           = 40042
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40043
    instance_protocol = "tcp"
    lb_port           = 40043
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40044
    instance_protocol = "tcp"
    lb_port           = 40044
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40045
    instance_protocol = "tcp"
    lb_port           = 40045
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40046
    instance_protocol = "tcp"
    lb_port           = 40046
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40047
    instance_protocol = "tcp"
    lb_port           = 40047
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40048
    instance_protocol = "tcp"
    lb_port           = 40048
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40049
    instance_protocol = "tcp"
    lb_port           = 40049
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40050
    instance_protocol = "tcp"
    lb_port           = 40050
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40051
    instance_protocol = "tcp"
    lb_port           = 40051
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40052
    instance_protocol = "tcp"
    lb_port           = 40052
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40053
    instance_protocol = "tcp"
    lb_port           = 40053
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40054
    instance_protocol = "tcp"
    lb_port           = 40054
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40055
    instance_protocol = "tcp"
    lb_port           = 40055
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40056
    instance_protocol = "tcp"
    lb_port           = 40056
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40057
    instance_protocol = "tcp"
    lb_port           = 40057
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40058
    instance_protocol = "tcp"
    lb_port           = 40058
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40059
    instance_protocol = "tcp"
    lb_port           = 40059
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40060
    instance_protocol = "tcp"
    lb_port           = 40060
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40061
    instance_protocol = "tcp"
    lb_port           = 40061
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40062
    instance_protocol = "tcp"
    lb_port           = 40062
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40063
    instance_protocol = "tcp"
    lb_port           = 40063
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40064
    instance_protocol = "tcp"
    lb_port           = 40064
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40065
    instance_protocol = "tcp"
    lb_port           = 40065
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40066
    instance_protocol = "tcp"
    lb_port           = 40066
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40067
    instance_protocol = "tcp"
    lb_port           = 40067
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40068
    instance_protocol = "tcp"
    lb_port           = 40068
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40069
    instance_protocol = "tcp"
    lb_port           = 40069
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40070
    instance_protocol = "tcp"
    lb_port           = 40070
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40071
    instance_protocol = "tcp"
    lb_port           = 40071
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40072
    instance_protocol = "tcp"
    lb_port           = 40072
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40073
    instance_protocol = "tcp"
    lb_port           = 40073
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40074
    instance_protocol = "tcp"
    lb_port           = 40074
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40075
    instance_protocol = "tcp"
    lb_port           = 40075
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40076
    instance_protocol = "tcp"
    lb_port           = 40076
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40077
    instance_protocol = "tcp"
    lb_port           = 40077
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40078
    instance_protocol = "tcp"
    lb_port           = 40078
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40079
    instance_protocol = "tcp"
    lb_port           = 40079
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40080
    instance_protocol = "tcp"
    lb_port           = 40080
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40081
    instance_protocol = "tcp"
    lb_port           = 40081
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40082
    instance_protocol = "tcp"
    lb_port           = 40082
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40083
    instance_protocol = "tcp"
    lb_port           = 40083
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40084
    instance_protocol = "tcp"
    lb_port           = 40084
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40085
    instance_protocol = "tcp"
    lb_port           = 40085
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40086
    instance_protocol = "tcp"
    lb_port           = 40086
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40087
    instance_protocol = "tcp"
    lb_port           = 40087
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40088
    instance_protocol = "tcp"
    lb_port           = 40088
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40089
    instance_protocol = "tcp"
    lb_port           = 40089
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40090
    instance_protocol = "tcp"
    lb_port           = 40090
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40091
    instance_protocol = "tcp"
    lb_port           = 40091
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40092
    instance_protocol = "tcp"
    lb_port           = 40092
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40093
    instance_protocol = "tcp"
    lb_port           = 40093
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40094
    instance_protocol = "tcp"
    lb_port           = 40094
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40095
    instance_protocol = "tcp"
    lb_port           = 40095
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40096
    instance_protocol = "tcp"
    lb_port           = 40096
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40097
    instance_protocol = "tcp"
    lb_port           = 40097
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40098
    instance_protocol = "tcp"
    lb_port           = 40098
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 40099
    instance_protocol = "tcp"
    lb_port           = 40099
    lb_protocol       = "tcp"
  }
}






################################################################################
# CF TCP Route53 DNS CNAME Record - TCP Domain
################################################################################
resource "aws_route53_record" "cf_tcp_lb_dns" {
  count   = var.enable_route_53
  zone_id = var.route53_zone_id
  name = var.tcp_domain
  type = "CNAME"
  ttl = "60"
  records = ["${aws_elb.cf_tcp_lb.dns_name}"]
}



output "dns_name" {value = aws_elb.cf_tcp_lb.dns_name}
output "lb_name"  {value = aws_elb.cf_tcp_lb.name }



#output "cf_tcp_lb_internal_security_group" {
#  value = "${aws_security_group.cf_tcp_lb_internal_security_group.id}"
#}
#output "cf_tcp_lb_security_group" {
#  value = "${aws_security_group.cf_tcp_lb_security_group.id}"
#}