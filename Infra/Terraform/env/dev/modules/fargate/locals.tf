locals {
  default_tags = {
    Environment = var.environment
    Project     = "SaaS-Automation"
    Module      = var.module
  }
}
