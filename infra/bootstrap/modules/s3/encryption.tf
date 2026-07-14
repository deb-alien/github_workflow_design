/**
* This resource configures server-side encryption for the S3 bucket, ensuring that all objects stored in the bucket are encrypted at rest.
* This is a security best practice to protect sensitive data from unauthorized access.
*/
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
