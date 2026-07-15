resource "aws_ecs_cluster" "this" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insight ? "enabled" : "disabled"
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.cluster_name
    }
  )
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.cluster_name}"
  retention_in_days = 30

  tags = merge(
    local.common_tags,
    {
      Name = "${local.cluster_name}-log-group"
    }
  )
}
