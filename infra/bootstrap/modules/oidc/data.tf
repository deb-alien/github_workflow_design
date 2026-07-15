# ==============================================================================
# DATA SOURCES: IDENTITY FEDERATION & TRUST POLICIES
# ==============================================================================

#* Generates the trust relationship policy allowing GitHub Actions to assume this role via OIDC
data "aws_iam_policy_document" "github_oidc_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_oidc.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_repo}:*"]
    }
  }
}


# ==============================================================================
# DATA SOURCES: PERMISSION POLICIES
# ==============================================================================

#* Generates permissions for managing backend infrastructure Terraform state files
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

#* Generates permissions for building, pushing, and authenticating with Amazon ECR
data "aws_iam_policy_document" "ecr_repository_policy" {
  #| ECR global authentication token generation must be granted against wildcard '*' resources
  statement {
    sid       = "AllowGitHubActionsToAuthenticateECR"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  #| Standard repository read and write access rules
  statement {
    sid    = "AllowGitHubActionsToAccessECRRepository"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = [var.ecr_repository_arn]
  }
}
