/**
# ==============================================================================
# S3 REMOTE STATE STORAGE
# ==============================================================================

* This resource creates an S3 bucket to store the Terraform state files.
* The bucket name is derived from the project name variable, ensuring that it is unique to the project.
*/
resource "aws_s3_bucket" "tf_state" {
  bucket        = local.tf_state_bucket_name
  force_destroy = false
}

/**
* This resource creates a public access block for the S3 bucket,
* ensuring that public access is blocked for the bucket and its objects.
*/
resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/**
* This disables ACLs for the S3 bucket, ensuring that only the bucket owner has access to the objects within the bucket.
* This is a security best practice to prevent unauthorized access to sensitive data stored in the S3 bucket.
*/
resource "aws_s3_bucket_ownership_controls" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

/**
* This resource enables versioning for the S3 bucket, allowing multiple versions of an object to be stored in the bucket.
* This is important for maintaining a history of changes to objects and for recovering from accidental deletions or overwrites.
*/
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

/**
* This resource configures server-side encryption for the S3 bucket, ensuring that all objects stored in the bucket are encrypted at rest.
* This is a security best practice to protect sensitive data from unauthorized access.
*/
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

/**
# ==============================================================================
# IDENTITY FEDERATION (GITHUB OIDC)
# ==============================================================================

* This resource creates an IAM OpenID Connect (OIDC) provider for GitHub Actions.
* This allows GitHub Actions to authenticate with AWS using OIDC,
* enabling secure access to AWS resources without the need for long-lived AWS credentials.
*/
resource "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]
}

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
# ==============================================================================
# AUTHORIZATION & ACCESS CONTROL
# ==============================================================================

* This data source generates an IAM policy document that allows GitHub Actions to access the S3 bucket used for storing Terraform state files.
* The policy document specifies the actions, resources, and conditions required for accessing the S3 bucket.
*/
data "aws_iam_policy_document" "tf_state_bucket_policy" {
  statement {
    sid       = "AllowGitHubActionsToAccessS3Bucket"
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.tf_state.arn}/*"]
  }
  statement {
    sid       = "AllowGitHubActionsToListS3Bucket"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.tf_state.arn]
  }
}

/**
* This resource creates an IAM role that can be assumed by GitHub Actions using OIDC.
* The role is granted the AdministratorAccess policy, allowing it to perform administrative actions in AWS.
* The role is also granted a custom policy that allows it to access the S3 bucket used for storing Terraform state files.
*/
resource "aws_iam_role" "github_oidc_role" {
  name               = "${upper(replace(var.project_name, "-", "_"))}_GITHUB_OIDC_ROLE"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "github_oidc_policy_attachment" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy" "tf_state_bucket_policy_attachment" {
  name   = "${upper(replace(var.project_name, "-", "_"))}_TF_STATE_BUCKET_POLICY"
  role   = aws_iam_role.github_oidc_role.name
  policy = data.aws_iam_policy_document.tf_state_bucket_policy.json
}
