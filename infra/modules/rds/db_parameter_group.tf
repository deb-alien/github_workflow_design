resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.project_name}-${var.environment}-db-parameter-group"
  family      = local.parameter_family
  description = "Custom parameter group for ${var.project_name}-${var.environment} RDS instance"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-parameter-group"
    }
  )
}
