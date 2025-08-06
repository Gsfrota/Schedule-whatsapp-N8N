output "public_ip" {
  value = aws_instance.n8n_dev.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.n8n_dev.public_ip}"
}

output "n8n_url" {
  value = "http://${aws_instance.n8n_dev.public_ip}:5678"
}
