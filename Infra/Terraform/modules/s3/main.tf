resource "aws_s3_bucket" "workflow" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "workflow" {
  bucket = aws_s3_bucket.workflow.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "workflow" {
  bucket = aws_s3_bucket.workflow.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"
    filter {
      
    }
    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}