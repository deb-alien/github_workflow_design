/**
* This resource enables versioning for the S3 bucket, allowing multiple versions of an object to be stored in the bucket.
* This is important for maintaining a history of changes to objects and for recovering from accidental deletions or overwrites.
*/
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}
