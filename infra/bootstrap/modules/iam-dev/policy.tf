resource "aws_iam_policy" "developer" {
  name        = "${var.project_name}-${var.environment}-developer"
  description = "IAM policy for developer access to S3 bucket ${var.bucket_arn}"
  policy      = data.aws_iam_policy_document.developer.json

  tags = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-developer-policy" })
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.developer.arn
}
