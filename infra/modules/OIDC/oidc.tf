/**
# ==============================================================================
# IDENTITY FEDERATION (GITHUB OIDC)
# ==============================================================================

* This resource creates an IAM OpenID Connect (OIDC) provider for GitHub Actions.
* This allows GitHub Actions to authenticate with AWS using OIDC,
* enabling secure access to AWS resources without the need for long-lived AWS credentials.
*/
resource "aws_iam_openid_connect_provider" "github_oidc" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]

  tags = merge(
    local.common_tags,
    {
      Name = "${upper(replace(var.project_name, "-", "_"))}_GITHUB_OIDC_PROVIDER"
    }
  )
}

# ==============================================================================
# AUTHORIZATION & ACCESS CONTROL
# ==============================================================================

/**
* This resource creates an IAM role that can be assumed by GitHub Actions using OIDC.
* The role is granted the AdministratorAccess policy, allowing it to perform administrative actions in AWS.
* The role is also granted a custom policy that allows it to access the S3 bucket used for storing Terraform state files.
*/
resource "aws_iam_role" "github_oidc_role" {
  name               = "${upper(replace(var.project_name, "-", "_"))}_GITHUB_OIDC_ROLE"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role_policy.json
  
  tags = merge(
    local.common_tags,
    {
      Name = "${upper(replace(var.project_name, "-", "_"))}_GITHUB_OIDC_ROLE"
    }
  )
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
