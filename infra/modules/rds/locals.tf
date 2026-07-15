locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "RDS"
  }
  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    db_username = {
      name        = "${local.parameter_prefix}/rds/db_username"
      value       = aws_db_instance.this.username
      description = "The username for the RDS database."
      type        = "String"
    }
    db_password = {
      name        = "${local.parameter_prefix}/rds/db_password"
      value       = aws_db_instance.this.password
      description = "The password for the RDS database."
      type        = "SecureString"
    }
    db_host = {
      name        = "${local.parameter_prefix}/rds/db_host"
      value       = aws_db_instance.this.endpoint
      description = "The endpoint of the RDS database."
      type        = "String"
    }
    db_port = {
      name        = "${local.parameter_prefix}/rds/db_port"
      value       = tostring(aws_db_instance.this.port)
      description = "The port of the RDS database."
      type        = "String"
    }
    db_name = {
      name        = "${local.parameter_prefix}/rds/db_name"
      value       = aws_db_instance.this.db_name
      description = "The name of the RDS database."
      type        = "String"
    }
  }

  db_instance_identifier   = "${var.project_name}-${var.environment}-db"
  db_name                  = "${var.project_name}_${var.environment}_db"
  postgres_major_version   = split(".", var.db_engine_version)[0]
  parameter_family         = "postgres${local.postgres_major_version}"
  rds_monitoring_role_name = "${var.project_name}-${var.environment}-rds-monitoring-role"
}
