variable "bucket_name" {
  description = "The name of the S3 bucket used for storing Terraform state files"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment for the project (e.g., dev, staging, production)"
  type        = string

}
