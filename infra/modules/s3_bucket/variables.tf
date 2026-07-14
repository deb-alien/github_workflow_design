variable "project_name" {
  description = "The name of the project. This is used to create unique resource names."
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., dev, staging, prod)."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to create."
  type        = string
}

variable "force_destroy" {
  description = "A boolean flag to indicate whether to force destroy the S3 bucket and its contents."
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "A boolean flag to indicate whether to enable versioning for the S3 bucket."
  type        = bool
  default     = true
}

# variable "cors_allowed_origins" {
#   description = "A list of allowed origins for CORS configuration."
#   type        = list(string)
#   default     = []
# }

# variable "cors_allowed_methods" {
#   description = "A list of allowed HTTP methods for CORS configuration."
#   type        = list(string)
#   default     = ["GET", "PUT", "HEAD"]
# }

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"

  type = list(object({
    id      = string
    prefix  = string
    enabled = optional(bool, true)

    transition = optional(object({
      days          = number
      storage_class = string
    }))

    expiration = optional(object({
      days = number
    }))
  }))
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for server-side encryption of the S3 bucket."
  type        = string
  default     = null
}

variable "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution associated with the S3 bucket."
  type        = string
}

variable "ecs_task_role_arn" {
  description = "The ARN of the ECS task role that needs access to the S3 bucket."
  type        = string
}
