output "primary_endpoint_address" {
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
  description = "The address of the primary endpoint for this replication group."
}

output "reader_endpoint_address" {
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
  description = "The address of the reader endpoint for this replication group."
}

output "port" {
  value       = aws_elasticache_replication_group.this.port
  description = "The port number on which each member of the replication group accepts connections."
}

output "elasticache_ssm_parameters" {
  description = "The SSM parameters for ElastiCache"
  value = {
    for key, param in aws_ssm_parameter.this : key => {
      name  = param.name
      arn   = param.arn
      type  = param.type
      value = param.value
    }
  }
  sensitive = true
}
