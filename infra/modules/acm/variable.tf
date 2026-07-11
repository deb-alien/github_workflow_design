variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment of the project."
  type        = string
}

variable "domain_name" {
  description = "Root domain name for the ACM certificate."
  type        = string
}

variable "hosted_zone_id" {
  description = "The Route53 hosted zone ID for the domain."
  type        = string
}
