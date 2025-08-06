variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "sa-east-1"
}

variable "tags" {
  description = "Tags aplicadas aos recursos"
  type        = map(string)
  default = {
    Project     = "n8n-saas"
    Environment = "dev"
    Owner       = "Gsfrota"
  }
}

variable "ssh_key_name" {
  description = "Nome da chave SSH para acesso (ainda necessária em alguns casos)"
  type        = string
  default     = "n8n-dev-key"
}

variable "ssh_public_key_path" {
  description = "Caminho do arquivo da chave pública"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "n8n_password" {
  description = "Senha para autenticação básica do n8n"
  type        = string
  sensitive   = true
}
