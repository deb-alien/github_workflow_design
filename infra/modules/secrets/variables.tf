variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., staging, production)."
  type        = string
}

variable "secrets" {
  description = "A map of secrets to be stored in AWS SSM Parameter Store."
  type = map(object({
    path        = string
    value       = string
    description = optional(string)
  }))
  sensitive = true
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encrypting the secrets in SSM Parameter Store."
  type        = string
  default     = null
}
