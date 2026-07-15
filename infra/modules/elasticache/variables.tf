variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "database_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "elasticache_security_group_ids" {
  description = "Security group IDs of ElastiCache"
  type        = list(string)
}

variable "engine_version" {
  description = "Valkey engine version"
  type        = string
  default     = "8.0"
}

variable "node_type" {
  description = "Cache node instance type"
  type        = string
  default     = "cache.t4g.micro"
}

variable "port" {
  description = "Cache port"
  type        = number
  default     = 6379
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "snapshot_window" {
  description = "Daily snapshot window"
  type        = string
  default     = "03:00-04:00"
}

variable "snapshot_retention_limit" {
  description = "Number of snapshot days"
  type        = number
  default     = 7
}

variable "at_rest_encryption_enabled" {
  type    = bool
  default = true
}

variable "transit_encryption_enabled" {
  type    = bool
  default = true
}

variable "automatic_failover_enabled" {
  type    = bool
  default = false
}

variable "multi_az_enabled" {
  type    = bool
  default = false
}

variable "num_cache_clusters" {
  description = "Number of cache nodes"
  type        = number
  default     = 1
}

variable "apply_immediately" {
  type    = bool
  default = false
}
