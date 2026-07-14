resource "aws_db_instance" "default" {
  identifier = local.db_instance_identifier

  #| Engine
  engine         = "postgres"
  engine_version = var.db_engine_version

  #| Instance Configuration
  instance_class = var.db_instance_class

  #| Storage Configuration
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = var.storage_encrypted

  #| Credentials
  db_name  = local.db_name
  username = var.master_username
  password = var.master_password
  port     = var.db_port

  #| Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = var.db_security_group_ids
  publicly_accessible    = false
  network_type           = "IPV4"

  #| Parameter Group
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name

  #| High Availability
  multi_az = var.multi_az

  #| Backup
  deletion_protection      = var.delete_protection
  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  delete_automated_backups = false
  skip_final_snapshot      = var.skip_final_snapshot
  final_snapshot_identifier = (
    var.skip_final_snapshot
    ? null
    : "${local.db_instance_identifier}-final"
  )
  copy_tags_to_snapshot = true

  #| Maintenance
  maintenance_window         = var.maintenance_window
  auto_minor_version_upgrade = true
  apply_immediately          = false


  #| Monitoring
  monitoring_role_arn             = aws_iam_role.rds_enhanced_monitoring_role.arn
  performance_insights_enabled    = var.performance_insights_enabled
  monitoring_interval             = var.monitoring_interval
  enabled_cloudwatch_logs_exports = var.enable_cloudwatch_logs_exports


  tags = merge(
    local.common_tags,
    {
      Name = local.db_instance_identifier
    }
  )
}
