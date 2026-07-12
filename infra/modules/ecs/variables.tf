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
