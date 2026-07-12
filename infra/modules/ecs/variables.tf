variable "aws_region" {
  description = "The AWS region where the ECS cluster will be created."
  type        = string
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g.., staging, production)"
  type        = string
}

variable "container_insight" {
  description = "Enable or disable container insights for the ECS cluster."
  type        = bool
  default     = true
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows ECS tasks to call AWS APIs on your behalf."
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that allows ECS tasks to call AWS APIs on your behalf."
  type        = string
}

variable "repository_url" {
  description = "The URL of the container image repository."
  type        = string
}

variable "image_tag" {
  description = "The tag of the container image."
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to reserve for the task. default is 256 (0.25 vCPU)."
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the task. default is 512 (0.5 GiB)."
  type        = number
  default     = 512
}

variable "container_port" {
  description = "The port on which the container listens for traffic."
  type        = number
}

variable "desired_count" {
  description = "The desired number of tasks to run in the ECS service."
  type        = number
  default     = 2
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the ECS service."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the ECS service."
  type        = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the target group to associate with the ECS service."
  type        = string
}

variable "health_check_path" {
  description = "The path for the health check endpoint."
  type        = string
  default     = "/api/health"
}

variable "enable_auto_scaling" {
  description = "Enable or disable auto-scaling for the ECS service."
  type        = bool
  default     = true
}

variable "min_capacity" {
  description = "The minimum number of tasks to run in the ECS service when auto-scaling is enabled."
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "The maximum number of tasks to run in the ECS service when auto-scaling is enabled."
  type        = number
  default     = 10
}

variable "cpu_utilization_target" {
  description = "The target CPU utilization percentage for the ECS service when auto-scaling is enabled."
  type        = number
  default     = 70
}

variable "memory_utilization_target" {
  description = "The target memory utilization percentage for the ECS service when auto-scaling is enabled."
  type        = number
  default     = 75
}

variable "scale_in_cooldown" {
  description = "The cooldown period (in seconds) after a scaling activity completes before another scaling activity can start."
  type        = number
  default     = 300
}

variable "scale_out_cooldown" {
  description = "The cooldown period (in seconds) after a scale-out activity completes before another scale-out activity can start."
  type        = number
  default     = 60
}
