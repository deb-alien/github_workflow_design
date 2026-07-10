locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "VPC"
  }

  azs = {
    for idx, az in var.availability_zones :
    "az${idx + 1}" => az
  }

  nat_gateway_count = (
    !var.enable_nat_gateway
    ? 0
    : var.single_nat_gateway
    ? 1
    : length(var.availability_zones)
  )

  nat_gateways = (
    !var.enable_nat_gateway
    ? {}
    : var.single_nat_gateway
    ? {
      az1 = local.public_subnets["az1"]
    }
    : local.public_subnets
  )

  private_nat_gateway_mapping = (
    !var.enable_nat_gateway ? {} :
    var.single_nat_gateway ? {
      for key in keys(aws_subnet.private) : key => "az1"
      } : {
      for key in keys(aws_subnet.private) : key => key
    }
  )
  public_subnets = {
    for index, az in keys(local.azs) : az => {
      availability_zone = local.azs[az]
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, index)
    }
  }

  private_subnets = {
    for index, az in keys(local.azs) : az => {
      availability_zone = local.azs[az]
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, index + 4)
    }
  }

  database_subnets = {
    for index, az in keys(local.azs) : az => {
      availability_zone = local.azs[az]
      cidr_block        = cidrsubnet(var.vpc_cidr, 4, index + 8)
    }
  }
}
