resource "aws_ssm_parameter" "this" {
  for_each = local.local_ssm_parameters

  name        = each.value.name
  value       = each.value.value
  description = each.value.description
  type        = each.value.type

  tags = local.common_tags
}
