locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "Cloudfront"
  }
  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    cloudfront_alias = {
      name        = "${local.parameter_prefix}/cloudfront/alias"
      type        = "String"
      description = "The alias of the CloudFront distribution"
      value       = var.aliases[0]
    }
    cloudfront_domain_name = {
      name        = "${local.parameter_prefix}/cloudfront/domain_name"
      type        = "String"
      description = "The domain name of the CloudFront distribution"
      value       = aws_cloudfront_distribution.this.domain_name
    }
    cloudfront_public_key_id = {
      name        = "${local.parameter_prefix}/cloudfront/public_key_id"
      type        = "SecureString"
      description = "The ID of the CloudFront public key"
      value       = aws_cloudfront_public_key.this.id
    }
    cloudfront_public_key_value = {
      name        = "${local.parameter_prefix}/cloudfront/public_key_value"
      type        = "SecureString"
      description = "The RSA 2048 private key used to sign CloudFront URLs"
      value       = tls_private_key.this.private_key_pem
    }
  }
}
