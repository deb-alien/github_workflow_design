/**
* This resource creates an S3 bucket with the specified name and tags.
* The bucket is configured with public access block, ownership controls, versioning, and server-side encryption to ensure security and data integrity.
*/
resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      Name = local.bucket_name
    }
  )
}
