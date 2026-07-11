data "aws_availability_zones" "azs" {
  state                  = "available"
  all_availability_zones = true
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr                = var.vpc_cidr
  map_public_ip_on_launch = true
  availability_zones      = slice(data.aws_availability_zones.azs.names, 0, tonumber(var.availability_zone_count))

  enable_nat_gateway = false
  single_nat_gateway = false
}

module "security_group" {
  source = "../../modules/security_group"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "route53" {
  source = "../../modules/route53"

  environment = var.environment

  domain_name  = var.root_domain_name
  private_zone = false
  sub_domain   = var.sub_domain

  alb_dns_name = module.alb.load_balancer_dns_name
  alb_zone_id  = module.alb.load_balancer_zone_id
}

module "acm" {
  source = "../../modules/acm"

  project_name = var.project_name
  environment  = var.environment

  domain_name    = var.root_domain_name
  hosted_zone_id = module.route53.zone_id
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  internal     = false
  enable_http2 = true
  idle_timeout = 60

  certificate_arn          = module.acm.certificate_arn
  ssl_policy               = var.ssl_policy
  enable_delete_protection = false

  container_port       = 3000
  health_check_path    = "/api/health"
  health_check_matcher = "200"

  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security_group.alb_security_group_id]
}
