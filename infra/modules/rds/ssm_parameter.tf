resource "aws_ssm_parameter" "rds_password" {
  name        = "${local.parameter_prefix}/rds/password"
  description = "The RDS instance password"
  type        = "SecureString"
  value       = var.master_password

  tags = merge(local.common_tags, { Name = "RDS Password" })
}

resource "aws_ssm_parameter" "rds_username" {
  name        = "${local.parameter_prefix}/rds/username"
  description = "The RDS instance username"
  type        = "String"
  value       = var.master_username

  tags = merge(local.common_tags, { Name = "RDS Username" })
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name        = "${local.parameter_prefix}/rds/endpoint"
  description = "The RDS instance endpoint"
  type        = "String"
  value       = aws_db_instance.default.endpoint

  tags = merge(local.common_tags, { Name = "RDS Endpoint" })
}

resource "aws_ssm_parameter" "rds_name" {
  name        = "${local.parameter_prefix}/rds/name"
  description = "The RDS instance name"
  type        = "String"
  value       = aws_db_instance.default.db_name

  tags = merge(local.common_tags, { Name = "RDS Name" })
}

resource "aws_ssm_parameter" "rds_port" {
  name        = "${local.parameter_prefix}/rds/port"
  description = "The RDS instance port"
  type        = "String"
  value       = aws_db_instance.default.port

  tags = merge(local.common_tags, { Name = "RDS Port" })
}
