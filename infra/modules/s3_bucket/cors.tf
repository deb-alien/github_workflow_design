# resource "aws_s3_bucket_cors_configuration" "this" {
#   bucket = aws_s3_bucket.this.bucket

#   cors_rule {
#     allowed_origins = var.cors_allowed_origins
#     allowed_methods = var.cors_allowed_methods
#     allowed_headers = ["*"]
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }
# }
