variable "github_repo" {
  description = "The GitHub repository URL for the project"
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing Terraform state files"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}
