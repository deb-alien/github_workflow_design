variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., development, staging, production)"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository URL for the project"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the ECR repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either 'MUTABLE' or 'IMMUTABLE'."
  }
}

variable "scan_on_push" {
  description = "Whether to enable image scanning on push for the ECR repository"
  type        = bool
  default     = true
}

variable "keep_tagged_images" {
  description = "The number of tagged images to keep in the ECR repository"
  type        = number
  default     = 10
}

variable "delete_untagged_after_days" {
  description = "The number of days after which untagged images should be deleted from the ECR repository"
  type        = number
  default     = 7
}
