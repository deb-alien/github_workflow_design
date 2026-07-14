locals {
  replication_group_id = "${var.project_name}-${var.environment}-cache"

  subnet_group_name = "${local.replication_group_id}-subnet-group"

  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    primary_endpoint = "${local.parameter_prefix}/elasticache/endpoint"
    reader_endpoint  = "${local.parameter_prefix}/elasticache/reader-endpoint"
    port             = "${local.parameter_prefix}/elasticache/port"
    password         = "${local.parameter_prefix}/elasticache/password"
  }


  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ElastiCache"
  }
}
