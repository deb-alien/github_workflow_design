resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-s3-vpce"
    }
  )
}
