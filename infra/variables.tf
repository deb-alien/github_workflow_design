variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}
