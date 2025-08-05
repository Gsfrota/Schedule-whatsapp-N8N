resource "aws_security_group" "n8n_sg" {
  name        = "n8n-dev-sg"
  description = "Permitir SSH e porta 5678 (n8n)"
  vpc_id      = var.vpc_id

  ingress {
    description = "Permitir SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Dev only
  }

  ingress {
    description = "Permitir acesso ao n8n"
    from_port   = 5678
    to_port     = 5678
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Dev only
  }

  egress {
    description = "Allow outbound internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name        = "n8n-dev-sg"
      Environment = var.environment
      Project     = "n8n-Automation"
      Module      = var.module
    },
    var.tags
  )
}
