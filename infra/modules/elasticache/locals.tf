locals {
  replication_group_id = "${var.project_name}-${var.environment}-cache"

  subnet_group_name = "${local.replication_group_id}-subnet-group"

  parameter_group_name = "${local.replication_group_id}-parameter-group"

  security_group_name = "${local.replication_group_id}-sg"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ElastiCache"
  }
}
