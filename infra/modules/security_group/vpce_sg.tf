# ==============================================================================
# | VPC ENDPOINTS SECURITY GROUP (PRODUCTION READY)
# ==============================================================================
resource "aws_security_group" "vpce" {
  name        = "${var.project_name}-${var.environment}-vpce-sg"
  description = "Security group for Interface VPC Endpoints"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-vpce-sg"
    }
  )
}
