data "aws_iam_policy_document" "application" {
  statement {
    sid    = "SSMRead"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_path}/*"
    ]
  }
  statement {
    sid    = "KMSDecrypt"
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]

    resources = [data.aws_kms_key.ssm.arn]

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "ssm.${data.aws_region.current.region}.amazonaws.com"
      ]
    }
  }

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
