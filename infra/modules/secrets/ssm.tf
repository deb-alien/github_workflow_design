resource "aws_ssm_parameter" "this" {
  for_each = var.secrets

  name        = "${local.parameter_prefix}/${trim(each.value.path, "/")}"
  description = try(each.value.description, null)

  type  = "SecureString"
  value = each.value.value

  key_id = var.kms_key_arn != null ? var.kms_key_arn : null
  tier   = "Standard"

  tags = merge(
    local.common_tags,
    {
      Name = replace(each.value.path, "/", "-")
    }
  )
}
