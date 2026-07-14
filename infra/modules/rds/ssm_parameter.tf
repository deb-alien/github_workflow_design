resource "aws_ssm_parameter" "rds_endpoint" {
  name        = local.ssm.db_host
  description = "The RDS instance endpoint"
  type        = "SecureString"
  value       = aws_db_instance.default.endpoint

  tags = merge(local.common_tags, { Name = "RDS Endpoint" })
}

resource "aws_ssm_parameter" "rds_port" {
  name        = local.ssm.db_port
  description = "The RDS instance port"
  type        = "SecureString"
  value       = tostring(aws_db_instance.default.port)

  tags = merge(local.common_tags, { Name = "RDS Port" })
}

resource "aws_ssm_parameter" "rds_name" {
  name        = local.ssm.db_name
  description = "The RDS instance name"
  type        = "SecureString"
  value       = aws_db_instance.default.db_name

  tags = merge(local.common_tags, { Name = "RDS Name" })
}

resource "aws_ssm_parameter" "rds_password" {
  name        = local.ssm.db_password
  description = "The RDS instance password"
  type        = "SecureString"
  value       = random_password.password.result

  tags = merge(local.common_tags, { Name = "RDS Password" })
}

resource "aws_ssm_parameter" "rds_username" {
  name        = local.ssm.db_username
  description = "The RDS instance username"
  type        = "SecureString"
  value       = var.master_username

  tags = merge(local.common_tags, { Name = "RDS Username" })
}
