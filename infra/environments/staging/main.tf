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
  availability_zones      = slice(data.aws_availability_zones.azs.names, 0, var.availability_zone_count)

  enable_nat_gateway = false
  single_nat_gateway = false
}

module "security_group" {
  source = "../../modules/security_group"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "../../modules/iam"

  project_name  = var.project_name
  environment   = var.environment
  s3_bucket_arn = module.s3_bucket.s3_bucket_arn
}

module "vpc_endpoints" {
  source = "../../modules/endpoints"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  vpc_id                  = module.vpc.vpc_id
  private_subnets_id      = module.vpc.private_subnet_ids
  vpce_security_group_id  = module.security_group.vpce_security_group_id
  private_route_table_ids = module.vpc.private_route_table_ids
}

module "route53" {
  source = "../../modules/route53"

  environment = var.environment

  domain_name  = var.root_domain_name
  private_zone = false
  sub_domain   = var.sub_domain

  alb_dns_name = module.alb.load_balancer_dns_name
  alb_zone_id  = module.alb.load_balancer_zone_id

  cloudfront_domain_name    = module.cloudfront.cloudfront_distribution_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
  cdn_aliases               = local.cdn_aliases
}

module "acm" {
  source = "../../modules/acm"

  project_name = var.project_name
  environment  = var.environment

  domain_name    = var.root_domain_name
  hosted_zone_id = module.route53.zone_id
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"

  project_name = var.project_name
  environment  = var.environment

  bucket_name       = "${var.project_name}-${var.environment}-storage-06-10-2026"
  enable_versioning = true
  kms_key_arn       = null

  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
  ecs_task_role_arn           = module.iam.task_role_arn

  lifecycle_rules = [
    {
      id      = "avatars"
      prefix  = "avatars/"
      enabled = true
      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      expiration = {
        days = 365
      }
    },
    {
      id      = "posts"
      prefix  = "posts/"
      enabled = true
      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      expiration = {
        days = 365
      }
    },
    {
      id      = "attachments"
      prefix  = "attachments/"
      enabled = true
      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }
      expiration = {
        days = 365
      }
    }
  ]
}

module "cloudfront" {
  source = "../../modules/cloudfront"

  project_name = var.project_name
  environment  = var.environment

  bucket_name                 = module.s3_bucket.s3_bucket_name
  bucket_regional_domain_name = module.s3_bucket.bucket_regional_domain_name
  aliases                     = local.cdn_aliases
  certificate_arn             = module.acm.certificate_arn
  wait_for_deployment         = true
  pricing_class               = "PriceClass_100"
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  internal     = false
  enable_http2 = true
  idle_timeout = 60

  custom_domain_name       = module.route53.api_record_fqdn
  certificate_arn          = module.acm.certificate_arn
  ssl_policy               = var.ssl_policy
  enable_delete_protection = false

  container_port       = var.container_port
  health_check_path    = var.health_check_path
  health_check_matcher = "200"

  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security_group.alb_security_group_id]
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  #| Credentials
  master_username = var.database_username
  master_password = var.database_password

  #| Network Configuration
  db_subnet_ids         = module.vpc.database_subnet_ids
  db_security_group_ids = [module.security_group.rds_security_group_id]

  #| Instance Configuration and Engine Version
  db_engine_version = "17.5"
  db_instance_class = "db.t3.micro"

  #| Storage Configuration
  storage_type          = "gp3"
  storage_encrypted     = true
  allocated_storage     = 20
  max_allocated_storage = 100

  #| Backup and Maintenance
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_retention_period = 7
  delete_protection       = false # for learning purposes, in production you should set this to true to prevent accidental deletion of the RDS instance
  skip_final_snapshot     = true  # for learning purposes, in production you should set this to false and create a final snapshot

  #| High Availability
  multi_az = false # for learning purposes, in production you should set this to true to enable Multi-AZ deployments for high availability

  #| Monitoring
  rds_monitoring_role_arn        = module.iam.rds_monitoring_role_arn
  performance_insights_enabled   = true
  monitoring_interval            = 60
  enable_cloudwatch_logs_exports = ["postgresql"]
}

module "ecs_cluster" {
  source = "../../modules/ecs"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  container_insight = true

  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn

  cpu    = var.cpu
  memory = var.memory

  repository_url = local.ecr_repository_url
  image_tag      = var.image_tag

  container_port     = var.container_port
  desired_count      = var.desired_count
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_group.ecs_security_group_id]
  target_group_arn   = module.alb.target_group_arn
  health_check_path  = var.health_check_path

  enable_auto_scaling       = true
  cpu_utilization_target    = 70
  memory_utilization_target = 75
  max_capacity              = 10
  min_capacity              = 1
  scale_in_cooldown         = 300
  scale_out_cooldown        = 60
}

module "ssm_parameter" {
  source = "../../modules/secrets"

  project_name = var.project_name
  environment  = var.environment

  secrets = {
    database_password = {
      path        = "database/password"
      value       = var.database_password
      description = "The password for the database user."
    }

    database_username = {
      path        = "database/username"
      value       = var.database_username
      description = "The username for the database."
    }

    database_host = {
      path        = "database/host"
      value       = module.rds.db_endpoint
      description = "The endpoint of the RDS database."
    }

    database_port = {
      path        = "database/port"
      value       = module.rds.db_port
      description = "The port of the RDS database."
    }

    s3_bucket_name = {
      path        = "s3/bucket_name"
      value       = module.s3_bucket.s3_bucket_name
      description = "The name of the S3 bucket."
    }
  }
}
