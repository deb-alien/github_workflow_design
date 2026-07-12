resource "aws_ecs_task_definition" "api" {
  family                   = "${local.cluster_name}-api"
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsondecode(local.container_definitions)

  tags = merge(
    local.common_tags,
    {
      Name = "${local.cluster_name}-task-definition"
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
