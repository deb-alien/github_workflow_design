output "execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.execution.arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.task.arn
}

output "secrets_policy_arn" {
  description = "ARN of the decoupled parameter and encryption access policy"
  value       = aws_iam_policy.secrets_access.arn
}

output "s3_policy_arn" {
  description = "ARN of the decoupled application storage access policy"
  value       = aws_iam_policy.s3_access.arn
}
