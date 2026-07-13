locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "IAM"
  }

  name_prefix = "${var.project_name}-${var.environment}"
  execution_role_name = "${local.name_prefix}-ecs-execution-role"
  task_role_name      = "${local.name_prefix}-ecs-task-role"
  application_policy_name = "${local.name_prefix}-application-policy"
  rds_monitoring_role_name = "${local.name_prefix}-rds-monitoring-role"
  parameter_path = "/${var.project_name}/${var.environment}/"
}
