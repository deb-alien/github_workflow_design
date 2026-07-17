locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "RDS"
  }
  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    database_username = {
      name        = "${local.parameter_prefix}/rds/username"
      value       = aws_db_instance.default.username
      description = "The administrative master service account username for the RDS database."
      type        = "SecureString"
    }
    database_password = {
      name        = "${local.parameter_prefix}/rds/password"
      value       = random_password.password.result
      description = "The cryptographically random master credential password for the RDS database."
      type        = "SecureString"
    }
    database_host = {
      name        = "${local.parameter_prefix}/rds/host"
      value       = aws_db_instance.default.endpoint
      description = "The fully qualified network ingress connection endpoint of the RDS database instance."
      type        = "String"
    }
    database_port = {
      name        = "${local.parameter_prefix}/rds/port"
      value       = tostring(aws_db_instance.default.port)
      description = "The target listener network communications port of the RDS database instance."
      type        = "String"
    }
    database_name = {
      name        = "${local.parameter_prefix}/rds/name"
      value       = coalesce(aws_db_instance.default.db_name, local.db_name)
      description = "The initial logical database instance storage name initialized inside the cluster."
      type        = "String"
    }
  }

  db_instance_identifier   = "${var.project_name}-${var.environment}-db"
  db_name                  = "${var.project_name}_${var.environment}_db"
  rds_monitoring_role_name = "${var.project_name}-${var.environment}-rds-monitoring-role"
  postgres_major_version   = split(".", var.db_engine_version)[0]
  parameter_family         = "postgres${local.postgres_major_version}"
}
