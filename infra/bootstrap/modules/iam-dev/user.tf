resource "aws_iam_user" "this" {
  name = local.user_name
  path = "/developer/"
  
  tags = merge(local.common_tags, { Name = local.user_name})
}
