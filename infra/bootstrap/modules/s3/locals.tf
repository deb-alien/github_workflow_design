locals {
  bucket_name = var.bucket_name

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "S3"
  }
}
