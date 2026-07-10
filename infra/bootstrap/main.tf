/**
* This resource creates an S3 bucket to store the Terraform state files.
* The bucket name is derived from the project name variable, ensuring that it is unique to the project.
*/
resource "aws_s3_bucket" "tf_state" {
  bucket        = local.tf_state_bucket_name
  force_destroy = false
}

/**
* This resource creates a public access block for the S3 bucket,
* ensuring that public access is blocked for the bucket and its objects.
*/
resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/**
* This disables ACLs for the S3 bucket, ensuring that only the bucket owner has access to the objects within the bucket.
* This is a security best practice to prevent unauthorized access to sensitive data stored in the S3 bucket.
*/
resource "aws_s3_bucket_ownership_controls" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

/**
* This resource enables versioning for the S3 bucket, allowing multiple versions of an object to be stored in the bucket.
* This is important for maintaining a history of changes to objects and for recovering from accidental deletions or overwrites.
*/
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

/**
* This resource configures server-side encryption for the S3 bucket, ensuring that all objects stored in the bucket are encrypted at rest.
* This is a security best practice to protect sensitive data from unauthorized access.
*/
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
