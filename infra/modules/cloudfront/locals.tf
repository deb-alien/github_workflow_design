locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "Cloudfront"
  }
  parameter_prefix = "/${var.project_name}/${var.environment}"

  ssm = {
    cloudfront_alias            = "${local.parameter_prefix}/cloudfront/alias"
    cloudfront_domain_name      = "${local.parameter_prefix}/cloudfront/domain_name"
    cloudfront_public_key_id    = "${local.parameter_prefix}/cloudfront/public_key_id"
    cloudfront_public_key_value = "${local.parameter_prefix}/cloudfront/public_key_value"
  }
}
