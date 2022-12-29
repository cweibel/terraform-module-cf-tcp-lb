# terraform-module-cf-tcp-lb
Terraform to create the load balancer for CF TCP Routing

This module will spin an ELB (default) or NLB for CF TCP Routing.  Note that there is a hard limit on the number of listeners for NLBs which is much lower than for ELBs.

Inputs - Required:

 - `resource_tags` - AWS tags to apply to resources
 - `vpc_id` - AWS VPC Id
 - `subnet_ids` - The AWS Subnet Id to place the lb into     
 - `tcp_domain` - url used for tcp routing default domain     
 - `route53_zone_id` - Route53 zone id
 - `private_cidrs` - CIDR ranges of all non-public ipv4 addresses
 - `security_groups ` - security group ids for bosh & deployments

Inputs - Optional: 

 - `enable_route_53` - Disable if using CloudFlare or other DNS (default = 1, to disable, set = 0)
 - `internal_lb` - Determine whether the load balancer is internal-only facing (default = true)
 - `start_port` - The starting range of ports to use for an ELB ( default = 40000 )
 - `end_port` - The starting range of ports to use for a NLB ( default = 40010 )
 - `type` - Choose your adventure on ELB v NLB ( default = "elb" )

Outputs:

 - `dns_name` - The A Record for the created load balancer
 - `lb_name` - Name of the load balancer.  Map this value in your cloud config

