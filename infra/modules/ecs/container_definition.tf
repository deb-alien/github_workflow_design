locals {
  container_definitions = [
    {
      name      = local.container_name
      image     = "${var.repository_url}:${var.image_tag}"
      essential = true

      cpu    = var.cpu
      memory = var.memory

      readonlyRootFilesystem = false


      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "NODE_ENV"
          value = var.environment
        },
        {
          name  = "PORT"
          value = tostring(var.container_port)
        }
      ]

      secrets = [
        # {
        #   name      = "DATABASE_URL"
        #   valueFrom = aws_ssm_parameter.database_url.arn
        # }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }

      healthCheck = {
        command = [
          "CMD-SHELL",
          "curl -f http://localhost:${var.container_port}/${trimprefix(var.health_check_path, "/")} || exit 1"
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 30
      }

      linuxParameters = {
        initProcessEnabled = true
      }

      stopTimeout = 120
    }
  ]
}
