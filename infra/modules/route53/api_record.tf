resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.this.zone_id

  name = local.record_name

  type = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
