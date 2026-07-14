# ==============================================================================
# | RDS POSTGRESQL SECURITY GROUP
# ==============================================================================
resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-rds-sg"
    }
  )
}

/**
  ** Ingress rules for the RDS security group
  ** This module defines the ingress rules for the RDS security group.
  ** It allows traffic from the ECS tasks to reach the PostgreSQL database.
*/
resource "aws_vpc_security_group_ingress_rule" "ecs_to_rds" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432

  description = "Allow PostgreSQL from ECS"
}

/**
  ** Egress rules for the RDS security group
  ** This module defines the egress rules for the RDS security group.
  ** It allows all outbound traffic from the RDS instance to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}
