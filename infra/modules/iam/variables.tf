variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., dev, staging, prod)."
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket to be used as the origin for the CloudFront distribution."
  type        = string
}
