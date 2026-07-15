resource "aws_ecs_task_definition" "api" {
  family                   = local.task_family
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn

  container_definitions = jsonencode(local.container_definitions)

  tags = merge(
    local.common_tags,
    {
      Name = local.task_family
    }
  )
}
