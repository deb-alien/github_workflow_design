output "tf_state_bucket_name" {
  value       = local.tf_state_bucket_name
  description = "The name of the S3 bucket for storing Terraform state files"
}

output "tf_state_bucket_arn" {
  value       = aws_s3_bucket.tf_state.arn
  description = "The ARN of the S3 bucket for storing Terraform state files"
}

output "github_oidc_role_arn" {
  value       = aws_iam_role.github_oidc_role.arn
  description = "The ARN of the IAM role for GitHub Actions OIDC"
}

output "github_oidc_role_name" {
  value       = aws_iam_role.github_oidc_role.name
  description = "The name of the IAM role for GitHub Actions OIDC"
}

output "tf_state_bucket_policy_name" {
  value       = aws_iam_role_policy.tf_state_bucket_policy_attachment.name
  description = "The name of the S3 bucket policy for Terraform state files"
}
