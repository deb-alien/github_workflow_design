locals {
  replication_group_id = "${var.project_name}-${var.environment}-cache"

  subnet_group_name = "${local.replication_group_id}-subnet-group"

  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    primary_endpoint = {
      name        = "${local.parameter_prefix}/elasticache/endpoint"
      value       = aws_elasticache_replication_group.this.primary_endpoint_address
      description = "The endpoint of the ElastiCache cluster."
      type        = "String"
    }
    reader_endpoint = {
      name        = "${local.parameter_prefix}/elasticache/reader-endpoint"
      value       = aws_elasticache_replication_group.this.reader_endpoint_address
      description = "The reader endpoint of the ElastiCache cluster."
      type        = "String"
    }
    port = {
      name        = "${local.parameter_prefix}/elasticache/port"
      value       = tostring(aws_elasticache_replication_group.this.port)
      description = "The port on which the ElastiCache cluster is listening."
      type        = "String"
    }
    password = {
      name        = "${local.parameter_prefix}/elasticache/password"
      value       = random_password.auth_token.result
      description = "The authentication token for the ElastiCache cluster."
      type        = "SecureString"
    }
  }


  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ElastiCache"
  }
}
