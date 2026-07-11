resource "aws_lb_target_group" "this" {
  name                          = "${var.project_name}-${var.environment}-tg"
  vpc_id                        = var.vpc_id
  protocol                      = "HTTP"
  target_type                   = "ip"
  port                          = var.container_port
  protocol_version              = "HTTP1"
  ip_address_type               = "ipv4"
  load_balancing_algorithm_type = "round_robin"
  deregistration_delay          = 30

  health_check {
    enabled             = true
    protocol            = "HTTP"
    port                = var.container_port
    matcher             = var.health_check_matcher
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-tg"
    }
  )
}
