module "fargate" {
  source          = "../../modules/fargate"
  environment     = "prod"
  module          = "fargate"
  client          = "internal"
  container_image = "n8nio/n8n"
  container_port  = 5678
  cpu             = 256
  memory          = 512
  min_tasks       = 1
  max_tasks       = 3
  enable_spot     = true

  subnets         = module.network.public_subnets
  security_groups = [module.security.sg_id]
  vpc_id          = module.network.vpc_id
}
