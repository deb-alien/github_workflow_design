/**
  ** IAM Policies for ECS Task Execution and Runtime Roles
  ** These policies define the permissions required for ECS tasks to access secrets and S3 resources.
  */
resource "aws_iam_policy" "secrets_access" {
  name        = "${var.project_name}-${var.environment}-secrets-policy"
  description = "Provides secure metadata parsing and KMS token decryption capabilities"
  policy      = data.aws_iam_policy_document.secrets_access.json
  tags        = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-secrets-policy" })
}

/**
  ** IAM Policy for S3 Access
  ** This policy grants ECS tasks permissions to access specific S3 bucket operations.
  */
resource "aws_iam_policy" "s3_access" {
  name        = "${var.project_name}-${var.environment}-s3-policy"
  description = "Provides runtime application access boundaries to private S3 file layers"
  policy      = data.aws_iam_policy_document.s3_access.json
  tags        = merge(local.common_tags, { Name = "${var.project_name}-${var.environment}-s3-policy" })
}
