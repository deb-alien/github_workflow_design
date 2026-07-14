output "tf_state_bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "The name of the S3 bucket for storing Terraform state files"
}

output "tf_state_bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the S3 bucket for storing Terraform state files"
}
