variable "repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags para o repositório"
  default     = {}
}
