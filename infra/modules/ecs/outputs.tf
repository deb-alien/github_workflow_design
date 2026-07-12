output "cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.api.name
}

output "service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.api.arn
}
