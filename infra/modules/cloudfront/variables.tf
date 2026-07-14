variable "project_name" {
  description = "The name of the project for which the S3 bucket is being created."
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., dev, staging, prod)."
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "Regional bucket domain name"
  type        = string
}

variable "aliases" {
  description = "The aliases for the S3 bucket"
  type        = list(string)
}

variable "certificate_arn" {
  description = "The ARN of the SSL/TLS certificate for the CloudFront distribution."
  type        = string
}

variable "pricing_class" {
  description = "The price class for the CloudFront distribution."
  type        = string
  default     = "PriceClass_100"
}

variable "wait_for_deployment" {
  description = "Whether to wait for the CloudFront distribution to be deployed before finishing the apply."
  type        = bool
  default     = false
}
