terraform {
  backend "s3" {
    bucket         = "n8n-workflows-dev"
    key            = "dev-basic/terraform.tfstate"
    region         = "sa-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
