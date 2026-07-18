# ==============================================================================
#* REMOTE IDENTITY & SECURITY DATA LOOKUPS
# ==============================================================================

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

#* Locates the default AWS managed key used to encrypt parameter assets
data "aws_kms_key" "ssm" {
  key_id = "alias/aws/ssm"
}


# ==============================================================================
#* IAM POLICY DOCUMENTS (SCHEMAS)
# ==============================================================================

/**
  * Mandates the explicit trust boundary allowing the ECS agent service
  * to assume these operational compute roles.
  */
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    sid    = "AllowEcsTasksToAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

/**
  ** Defined Least Privilege criteria granting permission to pull and
  ** decrypt credentials out of the AWS System Parameter Store.
*/
data "aws_iam_policy_document" "secrets_access" {
  statement {
    sid     = "SSMRead"
    effect  = "Allow"
    actions = ["ssm:GetParameter", "ssm:GetParameters", "ssm:GetParametersByPath"]
    resources = [
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_path}/*"
    ]
  }

  statement {
    sid       = "KMSDecrypt"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [data.aws_kms_key.ssm.arn]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["ssm.${data.aws_region.current.region}.amazonaws.com"]
    }
  }
}

/**
  ** Dedicated data boundary policy restricting active bucket objects
  ** modification permissions exclusively to your target S3 application array.
*/
data "aws_iam_policy_document" "s3_access" {
  statement {
    sid       = "ApplicationS3Access"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [var.s3_bucket_arn]
  }

  statement {
    sid       = "ApplicationS3ObjectAccess"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:ListMultipartUploadParts", "s3:AbortMultipartUpload"]
    resources = ["${var.s3_bucket_arn}/*"]
  }
}
