resource "aws_alb" "this" {
  name                             = "${var.project_name}-${var.environment}-alb"
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  internal                         = false
  security_groups                  = var.security_group_ids
  subnets                          = var.public_subnet_ids
  enable_deletion_protection       = var.enable_delete_protection
  enable_http2                     = true
  drop_invalid_header_fields       = true
  idle_timeout                     = 60

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-alb"
    }
  )
}
