data "aws_iam_policy_document" "bucket_access_policy_document" {
  statement {
    sid       = "AllowCloudFrontReadAccess"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_distribution_arn]
    }
  }

  statement {
    sid       = "AllowECSTaskRoleAccess"
    actions   = local.ecs_object_actions
    resources = ["${aws_s3_bucket.this.arn}/*"]
  }
  statement {
    sid       = "AllowECSTaskRoleListAccess"
    actions   = local.ecs_bucket_actions
    resources = [aws_s3_bucket.this.arn]
  }
}
