resource "aws_ssm_parameter" "cloudfront_private_key" {
  name        = "${local.parameter_prefix}/cloudfront/private_key"
  description = "The RSA 2048 private key used to sign CloudFront URLs"
  type        = "SecureString"
  value       = tls_private_key.this.private_key_pem

  tags = merge(local.common_tags, { Name = "CloudFront Private Key" })
}

resource "aws_ssm_parameter" "cloudfront_public_key_id" {
  name        = "${local.parameter_prefix}/cloudfront/public_key_id"
  description = "The ID of the CloudFront public key"
  type        = "String"
  value       = aws_cloudfront_public_key.this.id

  tags = merge(local.common_tags, { Name = "CloudFront Public Key ID" })
}
