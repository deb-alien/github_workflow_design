resource "aws_elasticache_replication_group" "this" {
  #| General
  replication_group_id = local.replication_group_id
  description          = "${var.project_name} ${var.environment} ElastiCache Replication Group"

  #| Engine
  engine         = "valkey"
  engine_version = var.engine_version
  node_type      = var.node_type

  #| Networking
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.elasticache_security_group_ids
  port               = var.port

  #| Topology
  num_cache_clusters         = var.num_cache_clusters
  automatic_failover_enabled = var.automatic_failover_enabled

  #| Security
  auth_token                 = random_password.auth_token.result
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled

  #| Maintenance
  auto_minor_version_upgrade = true
  apply_immediately          = var.apply_immediately
  maintenance_window         = var.maintenance_window

  #| Backup
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  #| Multi-AZ
  multi_az_enabled = var.multi_az_enabled


  tags = merge(local.common_tags, { Name = local.replication_group_id })

  lifecycle {
    create_before_destroy = true
  }
}
