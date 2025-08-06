resource "aws_ecr_repository" "n8n_custom" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "expire_old" {
  repository = aws_ecr_repository.n8n_custom.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire old images"
        selection = {
          tagStatus     = "any"
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
