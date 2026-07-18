resource "random_bytes" "jwt_access_token_secret" {
  length = 64
}

resource "random_bytes" "jwt_refresh_token_secret" {
  length = 64
}
