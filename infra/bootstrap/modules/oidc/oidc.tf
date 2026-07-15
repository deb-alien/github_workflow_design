# ==============================================================================
# IDENTITY FEDERATION (GITHUB OIDC)
# ==============================================================================

# Establishes the handshake configuration trust mapping between AWS and GitHub Actions
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

#* Creates the target IAM role assumed dynamically during GitHub CI/CD job operations
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

#* Attaches overarching infrastructure provisioning rights to the deployment pipeline role
resource "aws_iam_role_policy_attachment" "github_oidc_policy_attachment" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#* Attaches the structured container registry access limits directly to the execution role
resource "aws_iam_role_policy" "ecr_repository_policy_attachment" {
  name   = "${upper(replace(var.project_name, "-", "_"))}_ECR_REPOSITORY_POLICY"
  role   = aws_iam_role.github_oidc_role.name
  policy = data.aws_iam_policy_document.ecr_repository_policy.json
}

#* Attaches the remote state locking and tracking bucket rules to the execution role
resource "aws_iam_role_policy" "tf_state_bucket_policy_attachment" {
  name   = "${upper(replace(var.project_name, "-", "_"))}_TF_STATE_BUCKET_POLICY"
  role   = aws_iam_role.github_oidc_role.name
  policy = data.aws_iam_policy_document.tf_state_bucket_policy.json
}
