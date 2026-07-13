output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "The IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "The IDs of the private subnets"
}

output "database_subnet_ids" {
  value       = module.vpc.database_subnet_ids
  description = "The IDs of the database subnets"
}

output "vpce_interface_endpoints_ids" {
  value       = module.vpc_endpoints.interface_endpoints
  description = "Map of interface VPC endpoint IDs keyed by service name."
}

output "vpce_s3_gateway_endpoint_id" {
  value       = module.vpc_endpoints.s3_gateway_endpoint_id
  description = "The ID of the S3 gateway VPC endpoint"
}

output "load_balancer_dns_name" {
  value       = module.alb.load_balancer_dns_name
  description = "The DNS name of the ALB"
}

output "domain_name" {
  value       = module.route53.fqdn
  description = "The fully qualified domain name of the Route53 record"
}

output "load_balancer_arn" {
  value       = module.alb.load_balancer_arn
  description = "The ARN of the ALB"
}

output "load_balancer_zone_id" {
  value       = module.alb.load_balancer_zone_id
  description = "The canonical hosted zone ID of the ALB"
}

output "target_group_arn" {
  value       = module.alb.target_group_arn
  description = "The ARN of the target group"
}

output "http_listener_arn" {
  value       = module.alb.http_listener_arn
  description = "The ARN of the HTTP listener"
}
