resource "aws_ssm_parameter" "cloudfront_private_key_value" {
  name        = local.ssm.cloudfront_private_key_value
  description = "The RSA 2048 private key used to sign CloudFront URLs"
  type        = "SecureString"
  value       = tls_private_key.this.private_key_pem

  tags = merge(local.common_tags, { Name = "CloudFront Private Key" })
}

resource "aws_ssm_parameter" "cloudfront_public_key_id" {
  name        = local.ssm.cloudfront_public_key_id
  description = "The ID of the CloudFront public key"
  type        = "SecureString"
  value       = aws_cloudfront_public_key.this.id

  tags = merge(local.common_tags, { Name = "CloudFront Public Key ID" })
}

resource "aws_ssm_parameter" "cloudfront_domain_name" {
  name        = local.ssm.cloudfront_domain_name
  description = "The domain name of the CloudFront distribution"
  type        = "SecureString"
  value       = aws_cloudfront_distribution.this.domain_name

  tags = merge(local.common_tags, { Name = "CloudFront Domain Name" })
}

resource "aws_ssm_parameter" "cloudfront_alias" {
  name        = local.ssm.cloudfront_alias
  description = "The alias of the CloudFront distribution"
  type        = "SecureString"
  value       = values(var.aliases)[0]

  tags = merge(local.common_tags, { Name = "CloudFront Alias" })
}
