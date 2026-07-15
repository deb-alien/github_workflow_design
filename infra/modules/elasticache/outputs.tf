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

output "elasticache_auth_token" {
  value       = random_password.auth_token.result
  description = "The authentication token for the ElastiCache cluster."
  sensitive   = true
}
