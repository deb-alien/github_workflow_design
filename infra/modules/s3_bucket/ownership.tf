resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
