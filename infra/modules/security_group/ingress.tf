/**
  * Ingress rules for the ALB security group
  * This module defines the ingress rules for the Application Load Balancer (ALB) security group.
  * It allows HTTP and HTTPS traffic from the Internet to reach the ALB.
*/
resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow HTTP traffic from Internet"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow HTTPS traffic from Internet"
}

/**
  * Ingress rules for the ECS security group
  * This module defines the ingress rules for the ECS security group.
  * It allows traffic from the Application Load Balancer (ALB) to reach the ECS tasks.
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
  * Ingress rules for the RDS security group
  * This module defines the ingress rules for the RDS security group.
  * It allows traffic from the ECS tasks to reach the PostgreSQL database.
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
  * Ingress rules for the VPC Endpoint security group
  * This module defines the ingress rules for the VPC Endpoint (VPCE) security group.
  * It allows HTTPS traffic from the ECS tasks to reach the VPC Endpoint.
*/
resource "aws_vpc_security_group_ingress_rule" "ecs_to_vpce_https" {
  security_group_id            = aws_security_group.vpce.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  description = "Allow HTTPS from ECS tasks"
}
