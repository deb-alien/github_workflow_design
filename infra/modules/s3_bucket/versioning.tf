resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.bucket

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
