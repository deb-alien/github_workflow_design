output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.default.id
}

output "db_instance_identifier" {
  description = "The identifier of the RDS instance"
  value       = aws_db_instance.default.identifier
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.default.arn
}

output "db_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.default.endpoint
}

output "db_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.default.port
}

output "db_name" {
  description = "The name of the database"
  value       = aws_db_instance.default.db_name
}

output "db_hosted_zone_id" {
  description = "The hosted zone ID of the RDS instance"
  value       = aws_db_instance.default.hosted_zone_id
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.db_subnet_group.name
}

output "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  value       = aws_db_parameter_group.db_parameter_group.name
}
