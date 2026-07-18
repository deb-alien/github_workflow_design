output "iam_user_access_key_id" {
  value       = aws_iam_access_key.this.id
  description = "The access key ID for the IAM user"
  sensitive   = true
}

output "iam_user_secret_access_key" {
  value       = aws_iam_access_key.this.secret
  description = "The secret access key for the IAM user"
  sensitive   = true
}

output "iam_user_name" {
  value       = aws_iam_user.this.name
  description = "The name of the IAM user"
}
