terraform {
  backend "s3" {
    bucket       = "production-api-tf-state"
    key          = "production/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
