output "api_record_fqdn" {
  value       = aws_route53_record.api.fqdn
  description = "The fully qualified domain name of the Route53 record"
}

output "api_record_name" {
  value       = local.api_record_name
  description = "The name of the Route53 record"
}

output "cdn_record_fqdns" {
  value       = values(aws_route53_record.cdn)[*].fqdn
  description = "The fully qualified domain names of the Route53 CDN records"

}

output "cdn_record_names" {
  value       = local.cdn_record_names
  description = "The names of the Route53 CDN records"
}

output "zone_id" {
  value       = data.aws_route53_zone.this.zone_id
  description = "The ID of the Route53 zone"
}
