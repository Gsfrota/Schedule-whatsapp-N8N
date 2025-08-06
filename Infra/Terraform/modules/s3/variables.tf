variable "bucket_name" {
  type = string
  default = "n8n-workflows-dev"
}

variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = "dev"
    Project     = "Schedule-N8N"
  }
}