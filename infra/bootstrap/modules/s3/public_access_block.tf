/**
* This resource creates a public access block for the S3 bucket,
* ensuring that public access is blocked for the bucket and its objects.
*/
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
