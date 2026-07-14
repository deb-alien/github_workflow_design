locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    module      = "S3 Bucket"
  }
  bucket_name = var.bucket_name != "" ? var.bucket_name : "${var.project_name}-${var.environment}-storage"


  ecs_object_actions = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:ListMultipartUploadParts",
    "s3:AbortMultipartUpload"
  ]

  ecs_bucket_actions = [
    "s3:ListBucket"
  ]

}
