# ==============================================================================
# SECTION: PREREQUISITE BASE STORAGE & CONTAINER REGISTRIES
# ==============================================================================

# Dedicated S3 Bucket serving as the secure remote backend for state tracking and state locking
module "tf_state_bucket" {
  source = "./modules/s3"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Storage Configuration
  bucket_name = local.tf_state_bucket_name
}

# Amazon Elastic Container Registry (ECR) for hosting immutable Docker container images
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
# SECTION: IDENTITY FEDERATION & COMPUTE ACCESS CONTROL
# ==============================================================================

# GitHub Actions OpenID Connect (OIDC) trust infrastructure and granular access scoping
module "oidc" {
  source = "./modules/oidc"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Source Identity Scoping
  github_repo = var.github_repo

  #| Target Destination Permissions
  s3_bucket_arn      = module.tf_state_bucket.bucket_arn
  ecr_repository_arn = module.ecr_repository.ecr_repository_arn
}

# ==============================================================================
# SECTION: APPLICATION DEVELOPMENT ENVIRONMENT STORAGE
# ==============================================================================

# Dedicated S3 Bucket acting as the active cloud data store for development assets
module "development_bucket" {
  source = "./modules/s3"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Storage Configuration
  bucket_name = local.development_bucket_name
}

# ==============================================================================
# SECTION: DEVELOPER ACCOUNT SEPARATION & POLICIES
# ==============================================================================

# IAM Developer user access policies mapping restricted boundaries to storage arrays
module "iam_dev" {
  source       = "./modules/iam-dev"
  project_name = var.project_name
  environment  = var.environment

  bucket_arn = module.development_bucket.bucket_arn
}
