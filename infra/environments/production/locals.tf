locals {
  bootstrap_outputs = data.terraform_remote_state.bootstrap.outputs

  ecr_repository_url  = local.bootstrap_outputs.ecr_repository_url
}
