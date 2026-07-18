output "jwt_ssm_parameters" {
  description = "The SSM parameters for JWT secrets"
  value = {
    for key, param in local.local_ssm_parameters : key => {
      name  = param.name
      arn   = param.arn
      value = param.value
      type  = param.type
    }
  }
  sensitive = true
}
