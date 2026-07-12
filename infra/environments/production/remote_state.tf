data "terraform_remote_state" "bootstrap" {
  backend = "s3"
  config = {
    bucket       = var.terraform_remote_state_bucket
    key          = var.terraform_remote_state_key
    region       = var.aws_region
    use_lockfile = true
  }
}
