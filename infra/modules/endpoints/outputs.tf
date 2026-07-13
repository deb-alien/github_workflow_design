output "interface_endpoints" {
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.id
  }
  description = "Map of interface VPC endpoint IDs keyed by service name."
}

output "s3_gateway_endpoint_id" {
  value       = aws_vpc_endpoint.s3.id
  description = "The ID of the S3 gateway VPC endpoint"
}
