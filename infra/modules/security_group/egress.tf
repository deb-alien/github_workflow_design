/**
  * Security Group Egress Rules
  * This module defines the egress rules for the security groups used in the infrastructure.
  * It includes rules for allowing traffic from the Application Load Balancer (ALB) to the ECS tasks.
*/
resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = 3000
  to_port     = 3000

  description = "Forward traffic to ECS tasks"
}

/**
  * Egress rules for the ECS security group
  * This module defines the egress rules for the ECS security group.
  * It allows all outbound traffic from the ECS tasks to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "ecs_all" {
  security_group_id = aws_security_group.ecs.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}

/**
  * Egress rules for the RDS security group
  * This module defines the egress rules for the RDS security group.
  * It allows all outbound traffic from the RDS instance to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "rds_all" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}

/**
  * Egress rules for the VPC Endpoint security group
  * This module defines the egress rules for the VPC Endpoint security group.
  * It allows all outbound traffic from the VPC Endpoint to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "vpce_all" {
  security_group_id = aws_security_group.vpce.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow outbound traffic"
}
