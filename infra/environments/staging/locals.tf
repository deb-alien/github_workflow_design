locals {
  bootstrap_outputs = data.terraform_remote_state.bootstrap.outputs

  ecr_repository_name = local.bootstrap_outputs.ecr_repository_name
  ecr_repository_url  = local.bootstrap_outputs.ecr_repository_url
  ecr_repository_arn  = local.bootstrap_outputs.ecr_repository_arn
}
