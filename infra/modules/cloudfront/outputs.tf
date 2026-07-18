output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "cloudfront_distribution_aliases" {
  description = "The aliases of the CloudFront distribution"
  value       = var.aliases
}

output "cloudfront_public_key_id" {
  description = "The ID of the CloudFront public key"
  value       = aws_cloudfront_public_key.this.id
}

output "cloudfront_private_key_group_id" {
  description = "The ID of the CloudFront private key group"
  value       = aws_cloudfront_key_group.this.id
}

output "cloudfront_ssm_parameters" {
  description = "The SSM parameters for CloudFront"
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
