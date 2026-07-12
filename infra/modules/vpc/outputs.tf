output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "vpc_arn" {
  value       = aws_vpc.this.arn
  description = "The ARN of the VPC"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "The ID of the Internet Gateway"
}

output "public_subnet_ids" {
  value       = values(aws_subnet.public)[*].id
  description = "The IDs of the public subnets"
}

output "private_subnet_ids" {
  value       = values(aws_subnet.private)[*].id
  description = "The IDs of the private subnets"
}

output "database_subnet_ids" {
  value       = values(aws_subnet.database)[*].id
  description = "The IDs of the database subnets"
}

output "nat_gateway_ids" {
  value       = var.enable_nat_gateway ? values(aws_nat_gateway.this)[*].id : []
  description = "The IDs of the NAT Gateways"
}

output "nat_gateway_eip_ids" {
  value       = var.enable_nat_gateway ? values(aws_eip.this)[*].id : []
  description = "The IDs of the NAT Gateway Elastic IPs"
}

output "public_route_table_ids" {
  value       = aws_route_table.public.id
  description = "The IDs of the public route tables"
}

output "private_route_table_ids" {
  value       = values(aws_route_table.private)[*].id
  description = "The IDs of the private route tables"
}

output "database_route_table_ids" {
  value       = values(aws_route_table.database)[*].id
  description = "The IDs of the database route tables"
}
