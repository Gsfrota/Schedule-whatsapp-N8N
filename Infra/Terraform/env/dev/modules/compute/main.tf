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

locals {
  user_data = <<-EOF
    #!/bin/bash
    set -e

    export DEBIAN_FRONTEND=noninteractive

    echo "[INFO] Atualizando pacotes e instalando Docker..."
    apt-get update
    apt-get install -y docker.io curl unzip

    sleep 5
    systemctl start docker
    systemctl enable docker

    echo "[INFO] Criando volumes persistentes..."
    mkdir -p /root/n8n-data
    chown -R 1000:1000 /root/n8n-data

    echo "[INFO] Criando arquivo .env com variáveis do n8n..."
    cat <<EOT > /root/n8n.env
    N8N_PORT=5678
    N8N_HOST=0.0.0.0
    N8N_PROTOCOL=http
    N8N_LOG_LEVEL=info
    N8N_BASIC_AUTH_ACTIVE=true
    N8N_BASIC_AUTH_USER=admin
    N8N_BASIC_AUTH_PASSWORD=${var.n8n_password}
    N8N_SECURE_COOKIE=false
    TZ=America/Sao_Paulo
    EOT

    echo "[INFO] Baixando imagem n8n..."
    docker pull n8nio/n8n:1.85.0

    echo "[INFO] Iniciando container n8n..."
    docker run -d --restart unless-stopped \
      --name n8n \
      -p 5678:5678 \
      -v /root/n8n-data:/home/node/.n8n \
      --env-file /root/n8n.env \
      n8nio/n8n:1.85.0

    echo "[INFO] n8n iniciado com sucesso."
  EOF
}


# Variables esperadas:
# - instance_type
# - subnet_id
# - security_group_id
# - ssh_key_name
# - ssh_public_key_path
# - iam_instance_profile
# - tags
# - n8n_password


resource "aws_instance" "n8n_dev" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = local.user_data
  tags                        = var.tags
}
