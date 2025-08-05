resource "aws_ecr_repository" "n8n" {
  name                 = "n8n-dev"
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags
}
