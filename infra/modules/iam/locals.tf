locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "IAM"
  }

  name_prefix  = "${var.project_name}-${var.environment}"
}
