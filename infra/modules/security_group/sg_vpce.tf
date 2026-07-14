# ==============================================================================
# | VPC ENDPOINTS SECURITY GROUP (PRODUCTION READY)
# ==============================================================================
resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = "Security group for Interface VPC Endpoints"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpce-sg"
    }
  )
}

/**
  ** Ingress rules for the VPC Endpoint security group
  ** This module defines the ingress rules for the VPC Endpoint (VPCE) security group.
  ** It allows HTTPS traffic from the ECS tasks to reach the VPC Endpoint.
*/
resource "aws_vpc_security_group_ingress_rule" "ecs_to_vpce_https" {
  security_group_id            = aws_security_group.vpce.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  description = "Allow HTTPS from ECS tasks"
}

/**
  ** Egress rules for the VPC Endpoint security group
  ** This module defines the egress rules for the VPC Endpoint security group.
  ** It allows all outbound traffic from the VPC Endpoint to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "vpce_all" {
  security_group_id = aws_security_group.vpce.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}
