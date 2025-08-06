variable "vpc_cidr" {
  type        = string
  description = "CIDR da VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR da subnet pública"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Zona de disponibilidade da subnet"
  default     = "sa-east-1a"
}

variable "environment" {
  type        = string
  description = "dev"
}

variable "module" {
  type        = string
  description = "network"
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = "dev"
    Project     = "Schedule-N8N"
  }
}
