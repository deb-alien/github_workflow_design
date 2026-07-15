locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "Security Group"
  }

  alb_security_group_name         = "${var.project_name}-${var.environment}-alb-sg"
  ecs_security_group_name         = "${var.project_name}-${var.environment}-ecs-sg"
  rds_security_group_name         = "${var.project_name}-${var.environment}-rds-sg"
  vpce_security_group_name        = "${var.project_name}-${var.environment}-vpce-sg"
  elasticache_security_group_name = "${var.project_name}-${var.environment}-elasticache-sg"
}
