locals {
  bootstrap_outputs = data.terraform_remote_state.bootstrap.outputs.ecr

  ecr_repository_name = local.bootstrap_outputs.ecr.name
  ecr_repository_url  = local.bootstrap_outputs.ecr.url
  ecr_repository_arn  = local.bootstrap_outputs.ecr.arn
}
