variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain_name" {
  description = "The Root domain name for the Route53 zone"
  type        = string
}

variable "private_zone" {
  description = "Whether the Route53 zone is private or public"
  type        = bool
}

variable "sub_domain" {
  description = "The subdomain for the Route53 record"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB to create the Route53 record for"
  type        = string
}

variable "alb_zone_id" {
  description = "The zone ID of the ALB to create the Route53 record for"
  type        = string
}

variable "cdn_domain_aliases" {
  description = "The aliases for the CloudFront distribution"
  type        = list(string)
}

variable "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution"
  type        = string
}
