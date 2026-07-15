resource "aws_security_group" "elasticache" {
  name        = local.elasticache_security_group_name
  description = "Security group for ElastiCache"
  vpc_id      = var.vpc_id

  tags = merge(local.common_tags, { Name = local.elasticache_security_group_name })

  lifecycle {
    create_before_destroy = true
  }
}

/**
  ** Ingress rules for the ElastiCache security group
  ** This module defines the ingress rules for the ElastiCache security group.
  ** It allows ECS tasks to access ElastiCache.
*/
resource "aws_vpc_security_group_ingress_rule" "ecs_to_elasticache" {
  security_group_id            = aws_security_group.elasticache.id
  referenced_security_group_id = aws_security_group.ecs.id

  ip_protocol = "tcp"
  from_port   = var.elasticache_port
  to_port     = var.elasticache_port

  description = "Allow ECS tasks to access ElastiCache"
}

/**
  ** Egress rules for the ElastiCache security group
  ** This module defines the egress rules for the ElastiCache security group.
  ** It allows all outbound traffic from the ElastiCache instances to any destination.
*/
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.elasticache.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow all outbound traffic from ElastiCache"
}
