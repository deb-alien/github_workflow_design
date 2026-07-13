resource "aws_vpc_endpoint" "interface" {
  for_each = local.interface_endpoints

  vpc_id       = var.vpc_id
  service_name = each.value

  vpc_endpoint_type  = "Interface"
  security_group_ids = [var.ecs_security_group_id]
  subnet_ids         = var.private_subnets_id

  private_dns_enabled = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-${replace(each.value, ".", "-")}"
    }
  )
}
