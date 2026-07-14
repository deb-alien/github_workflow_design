output "tf_state_bucket_name" {
  sensitive   = true
  value       = module.tf_state_bucket.tf_state_bucket_name
  description = "The name of the S3 bucket for storing Terraform state files"
}

output "tf_state_bucket_arn" {
  sensitive   = true
  value       = module.tf_state_bucket.tf_state_bucket_arn
  description = "The ARN of the S3 bucket for storing Terraform state files"
}

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

output "cloudfront_public_key_id" {
  sensitive   = true
  value       = aws_cloudfront_key_group.this.id
  description = "The ID of the CloudFront key group"
}
