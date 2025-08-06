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
variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = "dev"
    Project     = "Schedule-N8N"
  }
}