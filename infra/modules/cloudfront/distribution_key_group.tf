resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_cloudfront_public_key" "this" {
  comment     = "${var.project_name}-public-key"
  encoded_key = tls_private_key.this.public_key_pem
  name_prefix = "${var.project_name}-public-key-"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_key_group" "this" {
  comment = "${var.project_name}-key-group"
  items   = [aws_cloudfront_public_key.this.id]
  name    = "${var.project_name}-key-group"
}
