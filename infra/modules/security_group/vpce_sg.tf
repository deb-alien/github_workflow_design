# ==============================================================================
#| VPC ENDPOINTS (ECR / SYSTEMS MANAGER / CLOUDWATCH) SECURITY GROUP
# ==============================================================================
resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = "Security group for VPC Endpoint"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-vpce-sg" })
}

resource "aws_vpc_security_group_ingress_rule" "vpce_ingress" {
  security_group_id            = aws_security_group.vpce.id
  referenced_security_group_id = aws_security_group.ecs.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
  description                  = "Allow HTTPS traffic from ECS security group to VPC Endpoint"
}

resource "aws_vpc_security_group_egress_rule" "vpce_egress" {
  security_group_id = aws_security_group.vpce.id
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic from VPC Endpoint"
}
