locals {
  tf_state_bucket_name = "${var.project_name}-tf-state"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Developer   = "deb-alien"
  }
}
