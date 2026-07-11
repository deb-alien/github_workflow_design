output "fqdn" {
  value       = aws_route53_record.alias.fqdn
  description = "The fully qualified domain name of the Route53 record"
}

output "record_name" {
  value       = local.record_name
  description = "The name of the Route53 record"
}
