output "cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "ecs_cluster_name" {
  description = "Value of the ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "ecs_task_definition_family" {
  description = "The family of the ECS task definition"
  value       = aws_ecs_task_definition.api.family
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.api.name
}

output "auto_scaling_target_arn" {
  description = "The ARN of the auto-scaling target for the ECS service"
  value       = try(aws_appautoscaling_target.ecs[0].arn, null)
}

output "container_name" {
  description = "The name of the container in the ECS task definition"
  value       = jsondecode(aws_ecs_task_definition.api.container_definitions)[0].name
}
