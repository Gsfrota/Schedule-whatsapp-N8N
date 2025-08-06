variable "aws_region" {
  type = string
  default = "sa-east-1"
  
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "ssh_key_name" {
  description = "Nome da chave SSH existente na AWS"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Caminho local para a chave pública"
  type        = string
  default = "/Users/guilhermefrota/Desktop/n8n-dev-key.pub"
}
variable "environment" {
  type        = string
  description = "dev"
}

variable "module" {
  type        = string
  description = "compute"
}
variable "workflow_bucket" {
  description = "The name of the workflow S3 bucket"
  type        = string
}
variable "iam_instance_profile" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = ""
    Project     = "Schedule-N8N"
    Name        = "n8n-dev-instance" 
  }
}

variable "n8n_password" {
  type        = string
  description = "Senha do usuário admin no n8n"
  sensitive   = true
}
