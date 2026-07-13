# * ==============================================================================
# | ECS FARGATE CONTAINER SECURITY GROUP
# * ==============================================================================
resource "aws_security_group" "ecs" {
  name        = "${var.project_name}-${var.environment}-ecs-sg"
  description = "Security group for ECS"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-ecs-sg" })
}

resource "aws_vpc_security_group_ingress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.ecs.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 3000
  to_port                      = 3000
  ip_protocol                  = "tcp"
  description                  = "Allow traffic from ALB to ECS"
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic from ECS"
}
