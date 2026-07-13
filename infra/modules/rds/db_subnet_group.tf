resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-db-subnet-group"
    }
  )
}
