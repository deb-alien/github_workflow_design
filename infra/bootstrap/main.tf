/**
  * This file is part of the Terraform configuration for bootstrapping the infrastructure.
  * It defines the necessary modules and resources required for setting up the initial state.
  */
module "tf_state_bucket" {
  source = "../modules/s3"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = local.tf_state_bucket_name
}
module "oidc" {
  source = "../modules/OIDC"

  project_name = var.project_name
  environment  = var.environment

  github_repo   = var.github_repo
  s3_bucket_arn = module.tf_state_bucket.tf_state_bucket_arn
}

module "ecr_repository" {
  source = "../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repository_name            = "api-ecr-repo"
  image_tag_mutability       = var.image_tag_mutability
  scan_on_push               = var.scan_on_push
  keep_tagged_images         = var.keep_tagged_images
  delete_untagged_after_days = var.delete_untagged_after_days
}
