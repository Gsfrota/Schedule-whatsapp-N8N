output "n8n_url" {
  value = module.compute.n8n_url
}

output "ssh_command" {
  value = module.compute.ssh_command
}

output "public_ip" {
  value = module.compute.public_ip
}
output "ecr_repository_url" {
  description = "URL da imagem customizada do n8n no ECR"
  value       = module.ecr_n8n_custom.repository_url
}
