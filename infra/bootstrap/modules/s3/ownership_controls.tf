/**
* This disables ACLs for the S3 bucket, ensuring that only the bucket owner has access to the objects within the bucket.
* This is a security best practice to prevent unauthorized access to sensitive data stored in the S3 bucket.
*/
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
