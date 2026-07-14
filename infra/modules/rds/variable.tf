variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the database"
  type        = list(string)
}

variable "db_security_group_ids" {
  description = "List of security group IDs for the database"
  type        = list(string)
}

variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class for the database"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage size for the database in GB"
  type        = number
}

variable "storage_type" {
  description = "The storage type for the database (e.g., gp2, gp3, io1)"
  type        = string
}

variable "storage_encrypted" {
  description = "Whether to enable storage encryption for the database"
  type        = bool
}

variable "max_allocated_storage" {
  description = "The maximum allocated storage size for the database in GB"
  type        = number
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
}

variable "master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "The port on which the database accepts connections"
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Whether to create a Multi-AZ database instance"
  type        = bool
}

variable "delete_protection" {
  description = "Whether to enable deletion protection for the database"
  type        = bool
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for the database"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the database"
  type        = bool
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 60
}

variable "performance_insights_enabled" {
  description = "Whether to enable Performance Insights for the database"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_logs_exports" {
  description = "Whether to enable exporting of database logs to CloudWatch Logs"
  type        = list(string)
  default     = ["postgresql"]
}
