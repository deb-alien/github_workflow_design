output "tf_state_bucket_name" {
  value       = module.tf_state_bucket.tf_state_bucket_name
  description = "The name of the S3 bucket for storing Terraform state files"
}

output "tf_state_bucket_arn" {
  value       = module.tf_state_bucket.tf_state_bucket_arn
  description = "The ARN of the S3 bucket for storing Terraform state files"
}

output "github_oidc_role_arn" {
  value       = module.oidc.github_oidc_role_arn
  description = "The ARN of the IAM role for GitHub Actions OIDC"
}

output "oidc_provider_arn" {
  value       = module.oidc.oidc_provider_arn
  description = "The ARN of the OIDC provider for GitHub Actions"
}

output "ecr" {
  description = "The ECR repository for storing Docker images"
  value = {
    name = module.ecr_repository.ecr_repository_name
    url  = module.ecr_repository.ecr_repository_url
    arn  = module.ecr_repository.ecr_repository_arn
  }
}
