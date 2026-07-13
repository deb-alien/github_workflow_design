# ==============================================================================
# HTTP LISTENER (PORT 80) - UNIVERSAL SSL REDIRECT
# ==============================================================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type = "redirect"
    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

# ==============================================================================
# HTTPS LISTENER (PORT 443) - DEFAULT ACCESS DENIED
# ==============================================================================
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.this.arn
  protocol          = "HTTPS"
  port              = 443
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Access Denied: Direct Application Load Balancer access is forbidden."
      status_code  = "403"
    }
  }
}

# ==============================================================================
# LISTENER RULE - EXCLUSIVE CUSTOM DOMAIN ROUTING
# ==============================================================================
resource "aws_lb_listener_rule" "allow_only_custom_domain" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = [var.custom_domain_name]
    }
  }
}
