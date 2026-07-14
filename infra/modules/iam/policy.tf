resource "aws_iam_policy" "application" {
  name        = local.application_policy_name
  description = "Permissions granted to the ECS application"

  policy = data.aws_iam_policy_document.application.json

  tags = merge(
    local.common_tags,
    {
      Name = local.application_policy_name
    }
  )
}
