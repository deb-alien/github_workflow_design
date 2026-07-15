# ==============================================================================
# PHASE 1: PREREQUISITE BASE STORAGE & CONTAINER REGISTRIES
# ==============================================================================

#* Dedicated S3 Bucket serving as the secure remote backend for state tracking and state locking
module "tf_state_bucket" {
  source = "./modules/s3"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Storage Configuration
  bucket_name = local.tf_state_bucket_name
}

#* Amazon Elastic Container Registry (ECR) for hosting immutable Docker container images
module "ecr_repository" {
  source = "./modules/ecr"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Container Image Configuration
  repository_name      = "api-ecr-repo"
  image_tag_mutability = var.image_tag_mutability

  #| Vulnerability Scan & Lifecycle Retention
  scan_on_push               = var.scan_on_push
  keep_tagged_images         = var.keep_tagged_images
  delete_untagged_after_days = var.delete_untagged_after_days
}


# ==============================================================================
# PHASE 2: IDENTITY FEDERATION & COMPUTE ACCESS
# ==============================================================================

#* GitHub Actions OpenID Connect (OIDC) trust infrastructure and granular access scoping
module "oidc" {
  source = "./modules/oidc"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Source Identity Scoping
  github_repo = var.github_repo

  #| Target Destination Permissions
  s3_bucket_arn      = module.tf_state_bucket.tf_state_bucket_arn
  ecr_repository_arn = module.ecr_repository.ecr_repository_arn
}
