output "load_balancer_dns_name" {
  value       = aws_alb.this.dns_name
  description = "The DNS name of the ALB"
}

output "load_balancer_arn" {
  value       = aws_alb.this.arn
  description = "The ARN of the ALB"
}

output "load_balancer_zone_id" {
  value       = aws_alb.this.zone_id
  description = "The zone ID of the ALB"
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "The ARN of the ALB target group"
}

output "target_group_name" {
  value       = aws_lb_target_group.this.name
  description = "The name of the ALB target group"
}

output "https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "The ARN of the HTTPS listener"
}

output "http_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "The ARN of the HTTP listener"
}
