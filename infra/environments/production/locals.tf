locals {
  bootstrap_outputs  = data.terraform_remote_state.bootstrap.outputs
  ecr_repository_url = local.bootstrap_outputs.ecr_repository_url
  cdn_domain_aliases = [
    "cdn.${var.root_domain_name}",
  ]

  ssm_parameters = merge(
    module.rds.rds_ssm_parameters,
    module.elasticache_valkey.elasticache_ssm_parameters,
    module.cloudfront.cloudfront_ssm_parameters,
    module.s3_bucket.s3_ssm_parameters,
    module.jwt.jwt_ssm_parameters
  )
}
