terraform {
  backend "s3" {
    bucket       = "github-actions-workflow-design"
    key          = "terraform/state/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
