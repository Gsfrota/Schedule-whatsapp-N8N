variable "name" {
  description = "Nome base da aplicação (ex: n8n-dev)"
  type        = string
}

variable "container_image" {
  description = "Imagem do container (ex: n8nio/n8n:latest)"
  type        = string
}

variable "container_port" {
  description = "Porta que o container expõe"
  type        = number
  default     = 5678
}

variable "desired_count" {
  description = "Número de containers"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "Subnets para rodar as tasks"
  type        = list(string)
}

variable "security_group_ids" {
  description = "SGs associados à task"
  type        = list(string)
}

variable "task_exec_role_arn" {
  description = "ARN da task role com permissões (S3, etc)"
  type        = string
}

variable "env_vars" {
  description = "Variáveis de ambiente do container"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC"
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS"
}

variable "ecs_cluster_id" {
  type        = string
  description = "ID do cluster ECS"
}

variable "tags" {
  type        = map(string)
  description = "Tags aplicadas aos recursos do ECS"
}

variable "aws_region" {
  type        = string
  description = "Região AWS onde os recursos serão criados"
  default     = "sa-east-1"
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string
}
variable "n8n_password_arn" {
  description = "ARN of the secret for N8N basic auth password"
  type        = string
}