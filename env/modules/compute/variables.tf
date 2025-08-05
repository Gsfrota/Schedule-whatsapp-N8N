variable "aws_region" {
  type = string
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
}
variable "environment" {
  type        = string
  description = "dev"
}

variable "module" {
  type        = string
  description = "compute"
}
