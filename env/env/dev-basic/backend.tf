terraform {
  backend "s3" {
    bucket         = "schedule-terraform-state"
    key            = "dev-basic/terraform.tfstate"
    region         = "sa-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
