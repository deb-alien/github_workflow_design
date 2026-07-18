locals {
  user_name = "${var.project_name}-${var.environment}-developer"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "IAM Developer"
  }
}
