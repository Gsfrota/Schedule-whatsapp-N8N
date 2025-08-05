#!/bin/bash

# Instala Docker e AWS CLI
apt update && apt install -y docker.io awscli unzip

# Cria diretório para workflow
mkdir -p /root/n8n-workflow

# Espera até o arquivo aparecer no S3 (timeout opcional)
until aws s3 ls s3://${workflow_bucket}/workflows/*.json; do
  echo "Esperando o workflow aparecer no bucket..."
  sleep 5
done

# Baixa o workflow diretamente do S3
aws s3 cp s3://${workflow_bucket}/workflows/latest.json /root/n8n-workflow/workflow.json

# Sobe o container n8n vazio
docker run -d --restart always \
  -p 5678:5678 \
  -v /root/n8n-data:/home/node/.n8n \
  --name n8n \
  n8nio/n8n

# Aguarda o n8n iniciar
sleep 15

# Importa o workflow no n8n dentro do container
docker exec n8n n8n import:workflow --input /root/n8n-workflow/workflow.json
