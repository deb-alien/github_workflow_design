resource "aws_acm_certificate" "this" {
  domain_name       = local.wildcard_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-wildcard"
    }
  )
}
