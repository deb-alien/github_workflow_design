variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., dev, staging, production)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "private_subnets_id" {
  description = "The IDs of the private subnets."
  type        = list(string)
}

variable "private_route_table_ids" {
  description = "The IDs of the private route tables."
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "The ID of the ECS security group."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
}
