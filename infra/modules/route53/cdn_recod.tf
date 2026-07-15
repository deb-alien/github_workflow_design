resource "aws_route53_record" "cdn" {
  for_each = toset(local.cdn_record_names)
  zone_id  = data.aws_route53_zone.this.zone_id

  name = each.value
  type = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cdn_ipv6" {
  for_each = toset(local.cdn_record_names)

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.value
  type    = "AAAA"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = false
  }
}
