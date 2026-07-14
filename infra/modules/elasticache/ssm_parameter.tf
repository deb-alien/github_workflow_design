resource "aws_ssm_parameter" "elasticache_endpoint" {
  name        = local.ssm.primary_endpoint
  description = "The endpoint of the ElastiCache cluster."
  type        = "SecureString"
  value       = aws_elasticache_replication_group.this.primary_endpoint_address

  tags = merge(local.common_tags, { Name = "ElastiCache Endpoint" })
}

resource "aws_ssm_parameter" "elasticache_reader_endpoint" {
  name        = local.ssm.reader_endpoint
  description = "The reader endpoint of the ElastiCache cluster."
  type        = "SecureString"
  value       = aws_elasticache_replication_group.this.reader_endpoint_address

  tags = merge(local.common_tags, { Name = "ElastiCache Reader Endpoint" })
}

resource "aws_ssm_parameter" "password" {
  name        = local.ssm.password
  description = "The authentication token for the ElastiCache cluster."
  type        = "SecureString"
  value       = random_password.auth_token.result

  tags = merge(local.common_tags, { Name = "ElastiCache Auth Token" })
}

resource "aws_ssm_parameter" "elasticache_port" {
  name        = local.ssm.port
  description = "The port on which the ElastiCache cluster is listening."
  type        = "SecureString"
  value       = tostring(aws_elasticache_replication_group.this.port)

  tags = merge(local.common_tags, { Name = "ElastiCache Port" })
}
