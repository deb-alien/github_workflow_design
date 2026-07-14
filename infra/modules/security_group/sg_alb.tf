# * ==============================================================================
# | APPLICATION LOAD BALANCER SECURITY GROUP
# * ==============================================================================
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-alb-sg"
    }
  )
}

/**
  ** Ingress rules for the ALB security group
  ** This module defines the ingress rules for the Application Load Balancer (ALB) security group.
  ** It allows HTTP and HTTPS traffic from the Internet to reach the ALB.
*/
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow HTTP traffic from Internet"
}

/**
  ** Ingress rules for the ALB security group
  ** This module defines the ingress rules for the Application Load Balancer (ALB) security group.
  ** It allows HTTPS traffic from the Internet to reach the ALB.
*/
resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow HTTPS traffic from Internet"
}

/**
  ** Egress rules for the ALB security group
  ** This module defines the egress rules for the Application Load Balancer (ALB) security group.
  ** It allows traffic from the ALB to reach the ECS tasks on port 3000.
*/
resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000

  description = "Forward traffic to ECS tasks"
}
