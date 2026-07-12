output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution IAM role."
  value       = aws_iam_role.task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS task IAM role."
  value       = aws_iam_role.ecs_task.arn
}
