## ==============================================================================
## PHASE 1: CORE NETWORKING & SECURITY FOUNDATION
## ==============================================================================
/**
  ## 1. Base VPC network topology (Subnets, Route Tables, Internet Gateways)
  ** Base VPC network topology (Subnets, Route Tables, Internet Gateways)
  ** This module provisions a VPC with public and private subnets, route tables, and an internet gateway.
  ** It allows the application to have a secure and isolated network environment in AWS.
*/
module "vpc" {
  source = "../../modules/vpc"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  vpc_cidr                = var.vpc_cidr
  availability_zones      = slice(data.aws_availability_zones.azs.names, 0, var.availability_zone_count)
  map_public_ip_on_launch = true

  #| High Availability & Routing
  enable_nat_gateway = false # Learning architecture; outbound traffic leverages VPC endpoints rather than costly NAT gateways
  single_nat_gateway = false
}

/**
  ## 2. Firewalls / Traffic rules protecting ALB, ECS Containers, and RDS Database
  ** Firewalls / Traffic rules protecting ALB, ECS Containers, and RDS Database
  ** This module provisions security groups for the Application Load Balancer (ALB), ECS tasks, and RDS database.
  ** It allows secure communication between the components of the application while restricting unauthorized access.
*/
module "security_group" {
  source = "../../modules/security_group"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  vpc_id             = module.vpc.vpc_id
  ecs_container_port = var.container_port
  elasticache_port   = var.elasticache_port
}

/**
  ## 3. IAM Policies and Roles providing AWS execution and task privileges (S3, ECR, CloudWatch)
  ** IAM Policies and Roles providing AWS execution and task privileges (S3, ECR, CloudWatch)
  ** This module provisions IAM roles and policies for ECS tasks to access AWS services like S3, ECR, and CloudWatch.
  ** It allows secure access to necessary resources for the application to function properly.
*/
module "iam" {
  source = "../../modules/iam"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Target Access Control
  s3_bucket_arn = module.s3_bucket.s3_bucket_arn
}

/**
  ## 4. Interface and Gateway VPC Endpoints for secure, private AWS service integrations within the VPC
  ** Interface and Gateway VPC Endpoints for secure, private AWS service integrations within the VPC
  ** This module provisions VPC endpoints for services like S3 and DynamoDB, allowing private access without traversing the public internet.
  ** It allows secure and efficient communication with AWS services from within the VPC.
*/
module "vpc_endpoints" {
  source = "../../modules/endpoints"

  #| Metadata
  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  vpc_id                  = module.vpc.vpc_id
  private_subnets_id      = module.vpc.private_subnet_ids
  vpce_security_group_id  = module.security_group.vpce_security_group_id
  private_route_table_ids = module.vpc.private_route_table_ids
}


## ==============================================================================
## PHASE 2: CERTIFICATES & DOMAIN ROUTING
## ==============================================================================

/**
  ## 5. Route 53 DNS Zone creation for apex and subdomain structures
  ** Route 53 DNS Zone creation for apex and subdomain structures
  ** This module provisions a public hosted zone in Route 53 for the domain and subdomain.
  ** It allows the application to be accessible via a custom domain name.
*/
module "route53" {
  source = "../../modules/route53"

  #| Metadata
  environment = var.environment

  #| Domain Routing
  domain_name  = var.root_domain_name
  sub_domain   = var.sub_domain
  private_zone = false # Public hosted zone reachable over the internet

  #| Target Ingress Aliases
  alb_dns_name              = module.alb.load_balancer_dns_name
  alb_zone_id               = module.alb.load_balancer_zone_id
  cloudfront_domain_name    = module.cloudfront.cloudfront_distribution_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
  cdn_aliases               = local.cdn_aliases
}

/**
  ## 6. Public SSL/TLS validation via AWS Certificate Manager (ACM)
  ** Public SSL/TLS validation via AWS Certificate Manager (ACM)
  ** This module provisions an ACM certificate for the domain and subdomain, enabling secure HTTPS connections.
*/
module "acm" {
  source = "../../modules/acm"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Domain Routing
  domain_name    = var.root_domain_name
  hosted_zone_id = module.route53.zone_id
}


## ==============================================================================
## PHASE 3: STORAGE & CONTENT DELIVERY NETWORKS (CDN)
## ==============================================================================

/**
  ## 7. S3 Data bucket containing lifecycle rules for avatars, posts, and attachments
  ** S3 Data bucket containing lifecycle rules for avatars, posts, and attachments
  ** This module provisions an S3 bucket with lifecycle rules for storing static media content.
  ** It allows efficient storage management and cost optimization for media assets.
*/
module "s3_bucket" {
  source = "../../modules/s3_bucket"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Storage Configuration
  bucket_name       = "${var.project_name}-${var.environment}-storage-06-11-2026"
  enable_versioning = true
  kms_key_arn       = null # Using Amazon S3 managed keys (SSE-S3) for basic default encryption

  #| Security & Access Control
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
  ecs_task_role_arn           = module.iam.task_role_arn

  #| Optimization & Lifecycle
  lifecycle_rules = [
    {
      id         = "avatars"
      prefix     = "avatars/"
      enabled    = true
      transition = { days = 30, storage_class = "STANDARD_IA" }
      expiration = { days = 365 }
    },
    {
      id         = "posts"
      prefix     = "posts/"
      enabled    = true
      transition = { days = 30, storage_class = "STANDARD_IA" }
      expiration = { days = 365 }
    },
    {
      id         = "attachments"
      prefix     = "attachments/"
      enabled    = true
      transition = { days = 30, storage_class = "STANDARD_IA" }
      expiration = { days = 365 }
    }
  ]
}

/**
  ## 8. CloudFront Edge distribution for static media caching using OAC & TLS key groups
  ** CloudFront Edge distribution for static media caching using OAC & TLS key groups
  ** This module provisions a CloudFront distribution that caches static media content from the S3 bucket.
  ** It allows faster content delivery to users by leveraging edge locations globally.
*/
module "cloudfront" {
  source = "../../modules/cloudfront"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Content Delivery Configuration
  bucket_regional_domain_name = module.s3_bucket.bucket_regional_domain_name
  aliases                     = local.cdn_aliases
  pricing_class               = "PriceClass_100" # Lowest cost option; optimizes edge locations to US, Canada, and Europe only

  #| Ingress Security & TLS
  certificate_arn     = module.acm.certificate_arn
  wait_for_deployment = true # Blocks infrastructure execution until the distribution is deployed across the CDN global edge
}


## ==============================================================================
## PHASE 4: DATA TIERS (PERSISTENCE)
## ==============================================================================
/**
  ## 9. Relational Database Service (RDS) Engine for state persistence in isolation
  ** Relational Database Service (RDS) Engine for state persistence in isolation
  ** This module provisions an RDS PostgreSQL instance for persistent data storage.
  ** It allows the application to store and retrieve data in a managed relational database.
*/
module "rds" {
  source = "../../modules/rds"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Credentials
  master_username = var.database_username

  #| Network Configuration
  db_subnet_ids         = module.vpc.database_subnet_ids
  db_security_group_ids = [module.security_group.rds_security_group_id]
  db_port               = 5432

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
  delete_protection       = false # For learning purposes; set to true in production
  skip_final_snapshot     = true  # For learning purposes; set to false in production

  #| High Availability
  multi_az = false # For learning purposes; set to true in production for HA

  #| Monitoring
  performance_insights_enabled   = true
  monitoring_interval            = 60
  enable_cloudwatch_logs_exports = ["postgresql"]
}

/**
  ## 10. ElastiCache Valkey cluster for caching and session management
  ** This module provisions an ElastiCache Valkey cluster for caching and session management.
  ** It allows the application to store and retrieve data quickly, improving performance and scalability.
*/

module "elasticache" {
  source = "../../modules/elasticache"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  vpc_id                         = module.vpc.vpc_id
  database_subnet_ids            = module.vpc.database_subnet_ids
  elasticache_security_group_ids = [module.security_group.elasticache_security_group_id]
  port                           = var.elasticache_port
}


## ==============================================================================
## PHASE 5: COMPUTE TIERS & PUBLIC APP ENTRY POINTS
## ==============================================================================
/**
  ## 11. Public-facing Application Load Balancer to terminate TLS and forward traffic to ECS
  ** Public-facing Application Load Balancer to terminate TLS and forward traffic to ECS
  ** This module provisions an Application Load Balancer (ALB) that terminates TLS connections and forwards traffic to the ECS service.
  ** It allows secure access to the application from the Internet.
*/
module "alb" {
  source = "../../modules/alb"

  #| Metadata
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security_group.alb_security_group_id]
  internal           = false #* Publicly accessible load balancer

  #| Ingress Security & TLS
  custom_domain_name       = module.route53.api_record_fqdn
  certificate_arn          = module.acm.certificate_arn
  ssl_policy               = var.ssl_policy
  enable_delete_protection = false #* For learning purposes; set to true in production to prevent accidental destruction

  #| Performance & Ingress Health
  enable_http2         = true
  idle_timeout         = 60
  container_port       = var.container_port
  health_check_path    = var.health_check_path
  health_check_matcher = "200"
}

/**
  ## 12. ECS Fargate Cluster, Task Definitions, and Service Auto-scaling
  ** ECS Fargate Cluster, Task Definitions, and Service Auto-scaling
  ** This module provisions an ECS cluster, defines task definitions, and configures service auto-scaling.
  ** It allows the application to run in a serverless container environment with automatic scaling based on resource utilization.
*/
module "ecs_cluster" {
  source = "../../modules/ecs"

  #| Metadata
  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment

  #| Network Configuration
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_group.ecs_security_group_id]
  target_group_arn   = module.alb.target_group_arn

  #| Identity & Security Policies
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn      = module.iam.task_role_arn

  #| Container Image Configuration
  repository_url = local.ecr_repository_url
  image_tag      = var.image_tag
  container_port = var.container_port

  #| Infrastructure Sizing
  cpu           = var.cpu
  memory        = var.memory
  desired_count = var.desired_count

  #| Scaling Policies
  enable_auto_scaling       = true
  min_capacity              = 2
  max_capacity              = 10
  cpu_utilization_target    = 70
  memory_utilization_target = 75
  scale_out_cooldown        = 60
  scale_in_cooldown         = 300

  #| Monitoring & Telemetry
  container_insight = true
  health_check_path = var.health_check_path
}
