locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    module      = "S3 Bucket"
  }
  bucket_name = var.bucket_name != "" ? var.bucket_name : "${var.project_name}-${var.environment}-storage"
}
