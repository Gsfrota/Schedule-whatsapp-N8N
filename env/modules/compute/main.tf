data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = var.ssh_key_name
  public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "n8n_dev" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y docker.io docker-compose
    docker run -d \
    -e N8N_HOST=0.0.0.0 \
    -e N8N_PORT=5678 \
    -e N8N_RUNNERS_ENABLED=true \
    -p 5678:5678 \
    -v n8n_data:/home/node/.n8n \
    --name n8n \
    n8nio/n8n
  EOF

  tags = {
    Name = "n8n-dev-instance"
    Environment = var.environment
    Project     = "n8n-Automation"
    Module      = var.module
  }
}
