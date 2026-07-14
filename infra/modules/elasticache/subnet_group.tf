resource "aws_elasticache_subnet_group" "this" {
  name       = local.subnet_group_name
  subnet_ids = var.database_subnet_ids

  tags = merge(local.common_tags, { Name = local.subnet_group_name })
}
