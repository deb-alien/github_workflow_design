# ==============================================================================
# OUTPUTS SECTION: TERRAFORM REMOTE STATE S3 PLATFORM METADATA
# ==============================================================================

output "tf_state_bucket_name" {
  sensitive   = true
  value       = module.tf_state_bucket.bucket_name
  description = "The name of the S3 bucket for storing Terraform state files"
}

output "tf_state_bucket_arn" {
  sensitive   = true
  value       = module.tf_state_bucket.bucket_arn
  description = "The ARN of the S3 bucket for storing Terraform state files"
}

# ==============================================================================
# OUTPUTS SECTION: OIDC FEDERATED SECURE ACCOUNT ACCESS ROLES
# ==============================================================================

output "github_oidc_role_arn" {
  sensitive   = true
  value       = module.oidc.github_oidc_role_arn
  description = "The ARN of the IAM role for GitHub Actions OIDC"
}

output "oidc_provider_arn" {
  sensitive   = true
  value       = module.oidc.oidc_provider_arn
  description = "The ARN of the OIDC provider for GitHub Actions"
}

# ==============================================================================
# OUTPUTS SECTION: REGISTRY COMPILER CONTAINER METADATA
# ==============================================================================

output "ecr_repository_url" {
  sensitive   = true
  value       = module.ecr_repository.ecr_repository_url
  description = "The URL of the ECR repository for storing Docker images"
}

output "ecr_repository_name" {
  sensitive   = true
  value       = module.ecr_repository.ecr_repository_name
  description = "The name of the ECR repository for storing Docker images"
}

output "ecr_repository_arn" {
  sensitive   = true
  value       = module.ecr_repository.ecr_repository_arn
  description = "The ARN of the ECR repository for storing Docker images"
}

# ==============================================================================
# OUTPUTS SECTION: APPLICATION DEVELOPMENT RUNTIME STORAGE ASSETS
# ==============================================================================

output "development_bucket_name" {
  sensitive   = true
  value       = module.development_bucket.bucket_name
  description = "The name of the S3 bucket for development storage"
}

output "development_bucket_arn" {
  sensitive   = true
  value       = module.development_bucket.bucket_arn
  description = "The ARN of the S3 bucket for development storage"
}

# ==============================================================================
# OUTPUTS SECTION: SYSTEM SERVICE ACCOUNT PLAIN KEYS
# ==============================================================================

output "iam_user_access_key_id" {
  sensitive   = true
  value       = module.iam_dev.iam_user_access_key_id
  description = "The access key ID for the IAM user"
}

output "iam_user_secret_access_key" {
  sensitive   = true
  value       = module.iam_dev.iam_user_secret_access_key
  description = "The secret access key for the IAM user"
}

output "iam_user_name" {
  sensitive   = true
  value       = module.iam_dev.iam_user_name
  description = "The name of the IAM user"
}
