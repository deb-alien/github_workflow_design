resource "aws_ssm_parameter" "s3_bucket_name" {
  name        = "${local.parameter_prefix}/s3/bucket_name"
  description = "The S3 bucket name"
  type        = "String"
  value       = aws_s3_bucket.this.bucket
  tags        = merge(local.common_tags, { Name = "S3 Bucket Name" })
}
