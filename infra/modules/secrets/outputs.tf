output "parameters" {
  description = "Created SSM parameters"

  value = {
    for key, parameter in aws_ssm_parameter.this : key => {
      name = parameter.name
      arn  = parameter.arn
    }
  }
}
