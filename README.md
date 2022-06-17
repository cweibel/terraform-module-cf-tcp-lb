# terraform-module-cf-tcp-lb
Terraform to create the load balancer for CF TCP Routing

This module will spin an ELB for CF TCP Routing.  This could also be a NLB but there is a hard limit on the number of listeners much lower than for ELBs.

Inputs - Required:

 - `resource_tags` - AWS tags to apply to resources
 - `vpc_id` - AWS VPC Id
 - `subnet_ids` - The AWS Subnet Id to place the lb into     
 - `tcp_domain` - url used for tcp routing default domain     
 - `route53_zone_id` - Route53 zone id
 - `private_cidrs` - CIDR ranges of all non-public ipv4 addresses
 - `security_groups ` - security group ids for bosh & deployments, this gets merged with the sg created in the module
 


Inputs - Optional: 

 - `enable_route_53` - Disable if using CloudFlare or other DNS (default = 1, to disable, set = 0)
 - `internal_lb` - Determine whether the load balancer is internal-only facing (default = true)

Outputs:

 - `dns_name` - The A Record for the created load balancer
 - `lb_name` - Name of the load balancer.  Map this value in your cloud config

