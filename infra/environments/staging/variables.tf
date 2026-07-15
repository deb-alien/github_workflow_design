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
  type        = number
  default     = 3


  validation {
    condition     = var.availability_zone_count >= 2 && var.availability_zone_count <= 6
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

variable "image_tag" {
  description = "The tag of the Docker image to use for the ECS service."
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to reserve for the container."
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the container."
  type        = number
  default     = 512
}

variable "terraform_remote_state_bucket" {
  description = "The S3 bucket name for storing Terraform remote state."
  type        = string
}

variable "terraform_remote_state_key" {
  description = "The S3 key for the Terraform remote state file."
  type        = string
  default     = "bootstrap/terraform.tfstate"
}

variable "container_port" {
  description = "The port on which the container listens."
  type        = number
  default     = 3000
}

variable "desired_count" {
  description = "The desired number of ECS tasks to run."
  type        = number
  default     = 2
}

variable "health_check_path" {
  description = "The path for the health check endpoint."
  type        = string
  default     = "/api/health"
}

variable "database_username" {
  description = "The username for the database."
  type        = string
  default     = "admin-api-user"
}

variable "elasticache_port" {
  description = "The port on which the ElastiCache cluster is listening."
  type        = number
  default     = 6379
}

variable "rds_port" {
  description = "The port on which the RDS instance is listening."
  type        = number
  default     = 5432
}
