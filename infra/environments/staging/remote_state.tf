data "terraform_remote_state" "bootstrap" {
  backend = "s3"
  config = {
    bucket       = var.terraform_remote_state_bucket
    key          = var.terraform_remote_state_key
    region       = "us-east-1"
    use_lockfile = true
  }
}
