variable subnet_ids            {}  # The AWS Subnet Id to place the lb into
variable resource_tags         {}  # AWS tags to apply to resources
variable vpc_id                {}  # The VPC Id
variable tcp_domain            {}  # url used for tcp routing default domain
variable route53_zone_id       {}  # Route53 zone id
variable private_cidrs         {}  # CIDR ranges of all non-public ipv4 addresses (required)
variable security_groups       {}  # Array of security groups to use
variable internal_lb           { default = true } # Determine whether the load balancer is internal-only facing

variable enable_route_53       { default = 1 }  # Disable if using CloudFlare or other DNS
variable start_port            { default = 40000 }
variable end_port              { default = 40010 }
variable type                  { default = "elb" }
locals {
  ports = toset(range(var.start_port, var.end_port))
}


####################################################################
# LB Flavor: NLB
####################################################################

resource "aws_lb" "cf_nlb_tcp_lb" {
  count              = var.type == "nlb" ? 1 : 0
  name               = "cf-tcp-lb"
  load_balancer_type = "network"
  internal           = var.internal_lb
  subnets            = var.subnet_ids
  tags               = merge(var.resource_tags, {Name = "cf-tcp-lb"})
  enable_cross_zone_load_balancing = true
}


resource "aws_lb_target_group" "cf_nlb_tcp_lb_tg" {
  count              = var.type == "nlb" ? 1 : 0
  name               = "cf-tcp-lb-tg"
  protocol           = "TCP"
  port               = 80
  vpc_id             = var.vpc_id
  tags               = merge(var.resource_tags, {Name = "cf-tcp-lb-tg"})
}

resource "aws_lb_listener" "cf_tcp_lb_listener" {
  count              = var.type == "nlb" ? 1 : 0
  #for_each           = local.ports
  #port               = each.key
  port               = var.start_port
  load_balancer_arn  = aws_lb.cf_nlb_tcp_lb[0].arn
  protocol           = "TCP"
  
  default_action {
    type             = "forward"
    target_groups_arn = aws_lb_target_group.cf_nlb_tcp_lb_tg[0].arn
    #target_groups_arn = aws_lb_target_group.cf_nlb_tcp_lb_tg[each.key].arn
  }
}

####################################################################
# LB Flavor: ELB
####################################################################

resource "aws_elb" "cf_elb_tcp_lb" {
  count                     = var.type == "elb" ? 1 : 0
  name                      = "cf-tcp-lb"
  cross_zone_load_balancing = true
  internal                  = var.internal_lb
  security_groups           = var.security_groups
  subnets                   = var.subnet_ids
  tags                      = merge({Name = "cf-tcp-lb"}, var.resource_tags)

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 5
    target              = "TCP:80"
    timeout             = 3
  }

  dynamic "listener" {
    for_each = local.ports
    content {
      instance_port     = listener.value
      instance_protocol = "tcp"
      lb_port           = listener.value
      lb_protocol       = "tcp"
    }
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
  records = [ var.type == "elb" ? aws_elb.cf_elb_tcp_lb[0].dns_name : aws_lb.cf_nlb_tcp_lb[0].dns_name ]
}



output "dns_name" {value = var.type == "elb" ? aws_elb.cf_elb_tcp_lb[0].dns_name : aws_lb.cf_nlb_tcp_lb[0].dns_name }
output "lb_name"  {value = "cf-tcp-lb" }


