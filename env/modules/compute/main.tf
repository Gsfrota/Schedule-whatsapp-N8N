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

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")
  vars = {
    ecr_url = module.ecr.repository_url
    region  = var.aws_region
    workflow_bucket = "n8n-workflows-dev"
  }
}

resource "aws_instance" "n8n_dev" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name

  user_data = data.template_file.user_data.rendered

  tags = var.tags
}
