resource "aws_ssm_parameter" "s3_bucket_name" {
  for_each = local.ssm

  name        = each.value.name
  description = each.value.description
  type        = each.value.type
  value       = each.value.value

  tags = local.common_tags
}
