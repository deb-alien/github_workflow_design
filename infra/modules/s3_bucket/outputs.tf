output "s3_bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "The name of the S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the S3 bucket"
}

output "bucket_id" {
  description = "Bucket ID"
  value       = aws_s3_bucket.this.id
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional bucket domain name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "s3_ssm_parameters" {
  description = "The SSM parameters for S3 bucket"
  value = {
    for key, param in aws_ssm_parameter.this : key => {
      name  = param.name
      arn   = param.arn
      type  = param.type
      value = param.value
    }
  }
  sensitive = true
}
