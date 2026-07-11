locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "ACM"
  }

  wildcard_domain_name = "*.${var.domain_name}"
}
