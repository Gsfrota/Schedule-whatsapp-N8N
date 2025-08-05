provider "aws" {
  region = var.aws_region
  profile = "PowerUserPlusRole-160071257600"
}

module "network" {
  source              = "../../modules/network"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  availability_zone   = "${var.aws_region}a"
  environment = "dev"
  module      = "network"

}

module "security" {
  source  = "../../modules/security"
  vpc_id  = module.network.vpc_id
  environment = "dev"
  module      = "security"
}

module "compute" {
  source              = "../../modules/compute"
  aws_region          = var.aws_region
  vpc_id              = module.network.vpc_id
  subnet_id           = module.network.subnet_id
  security_group_id   = module.security.security_group_id
  ssh_key_name        = var.ssh_key_name
  ssh_public_key_path = var.ssh_public_key_path
  workflow_bucket     = module.compute.workflow_bucket
  environment         = "dev"
  module              = "compute"
}
module "s3" {
  source      = "../../modules/s3"
  bucket_name = "n8n-workflows-dev"
  tags        = var.tags
}
module "iam" {
  source       = "../../modules/iam"
  role_name    = "n8n-dev-role"
  bucket_name  = module.s3.bucket_name
  tags         = var.tags
}