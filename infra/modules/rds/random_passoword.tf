resource "random_password" "password" {
  length  = 32
  special = true

  override_special = "!#$%&*()-_=+[]{}<>"

  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}
