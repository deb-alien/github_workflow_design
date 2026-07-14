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
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_path}/*"
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
        "ssm.${data.aws_region.current.name}.amazonaws.com"
      ]
    }
  }
}
