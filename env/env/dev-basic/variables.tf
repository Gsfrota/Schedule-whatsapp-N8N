variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "ssh_key_name" {
  type        = string
  description = "Nome da chave SSH já existente ou a ser criada"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Caminho da chave pública local (ex: ~/.ssh/id_rsa.pub)"
}
variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = "dev"
    Project     = "Schedule-N8N"
  }
}
variable "n8n_password" {
  type      = string
  sensitive = true
}