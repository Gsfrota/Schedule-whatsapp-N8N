variable "role_name" {
  type = string
}

variable "bucket_name" {
  type = string
}


variable "tags" {
  type = map(string)
  default = {
    Owner       = "guilherme.frota"
    Environment = "dev"
    Project     = "Schedule-N8N"
  }
}

variable "create_instance_profile" {
  type    = bool
  default = true
}
