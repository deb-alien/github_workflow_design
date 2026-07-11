variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "project_name" {
  description = "The name of the project. This will be used as a prefix for all resources created by this module."
  type        = string
}

variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, staging, production)."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "The VPC CIDR block is not valid."
  }
}

variable "availability_zone_count" {
  description = "Number of Availability Zones to use"
  type        = string
  default     = "3"

  validation {
    condition     = tonumber(var.availability_zone_count) >= 2 && tonumber(var.availability_zone_count) <= 6
    error_message = "The number of availability zones must be between 2 and 6."
  }
}

variable "ssl_policy" {
  description = "The SSL policy for the Application Load Balancer."
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}


variable "root_domain_name" {
  description = "The root domain name for the ACM certificate."
  type        = string
}

variable "sub_domain" {
  description = "The subdomain for the Route53 record."
  type        = string

}
