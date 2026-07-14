output "github_oidc_role_arn" {
  value       = aws_iam_role.github_oidc_role.arn
  description = "The ARN of the IAM role for GitHub Actions OIDC"
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.github_oidc.arn
  description = "The ARN of the OIDC provider for GitHub Actions"
}
