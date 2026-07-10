resource "aws_eip" "this" {
  count = local.nat_gateway_count

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "nat-eip-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  for_each = local.nat_gateways
  allocation_id = aws_eip.this[
    index(keys(local.nat_gateways), each.key)
  ].id

  subnet_id         = aws_subnet.public[each.key].id
  connectivity_type = "public"

  tags = merge(
    local.common_tags,
    {
      Name = "nat-gateway-${each.key}"
    }
  )
}
