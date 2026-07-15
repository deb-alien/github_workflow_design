locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ECS"
  }

  cluster_name   = "api-ecs-cluster-${var.environment}"
  container_name = "api-container-${var.environment}"
  task_family    = "api-task-definition-${var.environment}"
}
