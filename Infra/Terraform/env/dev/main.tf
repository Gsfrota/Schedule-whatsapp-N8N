provider "aws" {
  region  = var.aws_region
  profile = "PowerUserPlusRole-160071257600"
}

module "network" {
  source              = "../../modules/network"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  availability_zone   = "${var.aws_region}a"
  environment         = "dev"
  module              = "network"
}

module "security" {
  source      = "../../modules/security"
  vpc_id      = module.network.vpc_id
  environment = "dev"
  module      = "security"
}

module "iam" {
  source                  = "../../modules/iam"
  role_name               = "n8n-dev-role"
  bucket_name             = "n8n-workflows-dev"
  tags                    = var.tags
  create_instance_profile = false
}

module "ecr_n8n_custom" {
  source          = "../../modules/ecr"
  repository_name = "n8n-custom"
  tags            = var.tags
}

module "compute_ecs" {
  source               = "../../modules/compute-ecs"
  vpc_id               = module.network.vpc_id
  subnet_ids           = [module.network.subnet_id]
  security_group_ids   = [module.security.security_group_id]
  cluster_name         = "n8n-dev-cluster"
  ecs_cluster_id       = module.compute_ecs.ecs_cluster_id
  name                 = "n8n"
  container_image      = "${module.ecr_n8n_custom.repository_url}:latest"
  container_port       = 5678
  desired_count        = 1
  env_vars             = {
    N8N_BASIC_AUTH_USER = "admin"
    N8N_PORT            = "5678"
    N8N_HOST            = "0.0.0.0"
    N8N_PROTOCOL        = "http"
    N8N_LOG_LEVEL       = "info"
    N8N_SECURE_COOKIE   = "false"
    TZ                  = "America/Sao_Paulo"
  }
  acm_certificate_arn  = aws_acm_certificate.n8n.arn
  task_exec_role_arn   = module.iam.task_exec_role_arn
  tags                 = var.tags
  aws_region           = var.aws_region
}
