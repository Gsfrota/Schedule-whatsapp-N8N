variable "vpc_id" {
  description = "ID da VPC onde o SG será criado"
  type        = string
}
variable "environment" {
  type        = string
  description = "dev"
}

variable "module" {
  type        = string
  description = "security"
}