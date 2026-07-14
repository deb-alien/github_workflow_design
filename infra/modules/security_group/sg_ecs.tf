# * ==============================================================================
# | ECS FARGATE CONTAINER SECURITY GROUP
# * ==============================================================================
resource "aws_security_group" "ecs" {
  name        = "${var.project_name}-${var.environment}-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ecs-sg"
    }
  )
}

/**
  ** Ingress rules for the ECS security group
  ** This module defines the ingress rules for the ECS security group.
  ** It allows traffic from the Application Load Balancer (ALB) to reach the ECS tasks.
*/
resource "aws_vpc_security_group_ingress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.ecs.id
  referenced_security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000

  description = "Allow traffic from ALB"
}

/**
  ** Egress rules for the ECS security group
  ** This module defines the egress rules for the ECS security group.
  ** It allows all outbound traffic from the ECS tasks to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "ecs_all" {
  security_group_id = aws_security_group.ecs.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}
