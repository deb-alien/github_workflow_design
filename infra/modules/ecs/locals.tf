locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ECS"
  }

  cluster_name   = "${var.project_name}-${var.environment}-ecs-cluster"
  container_name = "${var.project_name}-${var.environment}-api"
}
