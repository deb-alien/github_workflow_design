variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment of the project (e.g., dev, staging, prod)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed."
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal or internet-facing."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Whether to enable HTTP/2 for the ALB."
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The idle timeout for the ALB in seconds."
  type        = number
  default     = 60
}

variable "enable_delete_protection" {
  description = "Whether to enable deletion protection for the ALB."
  type        = bool
}

variable "public_subnet_ids" {
  description = "A list of subnet IDs where the ALB will be deployed."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the ALB."
  type        = list(string)
}

variable "container_port" {
  description = "The port on which the container is listening."
  type        = number
}

variable "health_check_path" {
  description = "The path for the health check of the ALB."
  type        = string
}

variable "health_check_matcher" {
  description = "The HTTP response code to use when checking for a successful response from a target."
  type        = string
  default     = "200-299"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to use for HTTPS."
  type        = string
}

variable "ssl_policy" {
  type        = string
  description = "The security policy that defines which ciphers and protocols are supported."
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "custom_domain_name" {
  description = "The custom domain name for the ALB."
  type        = string
}
