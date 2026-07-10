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
