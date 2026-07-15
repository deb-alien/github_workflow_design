locals {
  api_record_name = (
    var.environment == "production"
    ? "${var.sub_domain}.${var.domain_name}"
    : "${var.environment}-${var.sub_domain}.${var.domain_name}"
  )

  cdn_record_names = [
    for cdn in var.cdn_domain_aliases : (
      var.environment == "production"
      ? cdn
      : "${var.environment}-${cdn}"
    )
  ]
}
