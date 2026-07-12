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
