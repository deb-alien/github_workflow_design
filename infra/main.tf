data "aws_availability_zones" "azs" {
  state                  = "available"
  all_availability_zones = true
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr                = var.vpc_cidr
  map_public_ip_on_launch = true
  availability_zones      = slice(data.aws_availability_zones.azs.names, 0, var.availability_zone_count)

  enable_nat_gateway = false
  single_nat_gateway = false
}
