locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "JWT"
  }
  parameter_prefix = "/${var.project_name}/${var.environment}"

  local_ssm_parameters = {
    jwt_access_token_secret = {
      name        = "${local.parameter_prefix}/jwt_access_token_secret"
      value       = random_bytes.jwt_access_token_secret.result
      description = "The secret used for signing JWT access tokens."
      type        = "SecureString"
    }
    jwt_refresh_token_secret = {
      name        = "${local.parameter_prefix}/jwt_refresh_token_secret"
      value       = random_bytes.jwt_refresh_token_secret.result
      description = "The secret used for signing JWT refresh tokens."
      type        = "SecureString"
    }
  }
}
