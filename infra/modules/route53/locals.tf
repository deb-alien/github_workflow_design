locals {
  record_name = (
    var.environment == "production"
    ? "${var.sub_domain}.${var.domain_name}"
    : "${var.environment}-${var.sub_domain}.${var.domain_name}"
  )
}
