/**
* This data source generates an IAM policy document that allows GitHub Actions to assume a role in AWS using OIDC.
* The policy document specifies the actions, principals, and conditions required for the role assumption.
*/
data "aws_iam_policy_document" "github_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_oidc.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}

/**
* This data source generates an IAM policy document that allows GitHub Actions to access the S3 bucket used for storing Terraform state files.
* The policy document specifies the actions, resources, and conditions required for accessing the S3 bucket.
*/
data "aws_iam_policy_document" "tf_state_bucket_policy" {
  statement {
    sid       = "AllowGitHubActionsToAccessS3Bucket"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${var.s3_bucket_arn}/*"]
  }
  statement {
    sid       = "AllowGitHubActionsToListS3Bucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [var.s3_bucket_arn]
  }
}
