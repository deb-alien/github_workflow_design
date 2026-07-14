output "execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.execution.arn
}

output "execution_role_name" {
  description = "Name of the ECS execution role"
  value       = aws_iam_role.execution.name
}

output "execution_role_id" {
  description = "ID of the ECS execution role"
  value       = aws_iam_role.execution.id
}

output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.task.arn
}

output "task_role_name" {
  description = "Name of the ECS task role"
  value       = aws_iam_role.task.name
}

output "task_role_id" {
  description = "ID of the ECS task role"
  value       = aws_iam_role.task.id
}

output "application_policy_arn" {
  description = "ARN of the application IAM policy"
  value       = aws_iam_policy.application.arn
}

output "application_policy_name" {
  description = "Name of the application IAM policy"
  value       = aws_iam_policy.application.name
}


