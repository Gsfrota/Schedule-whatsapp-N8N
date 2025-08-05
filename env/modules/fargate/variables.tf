variable "environment" {
  type        = string
  description = "Ambiente do serviço (dev, prod, etc.)"
}

variable "module" {
  type        = string
  description = "Nome do módulo (para tagging)"
}

variable "client" {
  type        = string
  description = "Identificação do cliente"
  default     = "internal"
}

variable "container_image" {
  type        = string
  description = "Imagem Docker a ser utilizada"
}

variable "container_port" {
  type        = number
  default     = 5678
  description = "Porta de exposição do container"
}

variable "cpu" {
  type        = number
  default     = 256
}

variable "memory" {
  type        = number
  default     = 512
}

variable "min_tasks" {
  type        = number
  default     = 1
}

variable "max_tasks" {
  type        = number
  default     = 3
}

variable "enable_spot" {
  type        = bool
  default     = false
  description = "Habilita Fargate Spot"
}

variable "subnets" {
  type        = list(string)
  description = "Lista de subnets públicas ou privadas"
}

variable "security_groups" {
  type        = list(string)
  description = "Security Groups para o serviço ECS"
}
variable "vpc_id" {
  type        = string
  description = "VPC ID onde o ALB será criado"
}
