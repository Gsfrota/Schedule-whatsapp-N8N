terraform {
  backend "s3" {
    bucket         = "schedule-terraform-state"
    key            = "dev-basic/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
