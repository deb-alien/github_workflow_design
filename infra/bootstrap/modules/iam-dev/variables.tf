variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, production)"
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket to which the IAM user will have access"
  type        = string
}
