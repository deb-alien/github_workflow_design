locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "RDS"
  }

  db_instance_identifier = "${var.project_name}-${var.environment}-db"
  db_name                = "${var.project_name}-${var.environment}-db"
  postgres_major_version = split(".", var.db_engine_version)[0]
  parameter_family       = "postgres${local.postgres_major_version}"
}
