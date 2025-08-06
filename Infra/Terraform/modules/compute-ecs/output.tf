output "alb_dns_name" {
  description = "URL pública da aplicação"
  value       = aws_lb.this.dns_name
}
