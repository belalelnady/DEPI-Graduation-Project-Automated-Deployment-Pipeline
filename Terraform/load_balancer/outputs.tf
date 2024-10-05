output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "target_group_arn" {
  value       = aws_lb_target_group.tg.arn
}
