# ==============================================================================
# | VPC ENDPOINTS SECURITY GROUP (PRODUCTION READY)
# ==============================================================================
resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = "Security group for VPC Endpoint"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-vpce-sg" })
}

resource "aws_vpc_security_group_ingress_rule" "vpce_ingress_from_ecs" {
  security_group_id            = aws_security_group.vpce.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ecs.id
  description                  = "Allow HTTPS traffic from the running ECS task containers"
}

resource "aws_vpc_security_group_ingress_rule" "vpce_ingress_from_fargate_agent" {
  security_group_id = aws_security_group.vpce.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = var.vpc_cidr_block
  description       = "Allow HTTPS traffic from internal VPC subnets for Fargate image pull orchestration"
}

resource "aws_vpc_security_group_egress_rule" "vpce_egress" {
  security_group_id = aws_security_group.vpce.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic from VPC Endpoint"
}
