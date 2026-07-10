variable "project_name" {
  description = "The name of the project. This will be used as a prefix for all resources created by this module."
  type        = string
}

variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, staging, prod)."
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to assign a public IP address to instances launched in the public subnets."
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "A list of availability zones to be used for the subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnets."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to create a single NAT Gateway for all private subnets (if enable_nat_gateway is true)."
  type        = bool
  default     = false
}
