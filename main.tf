module "vpc" {
  source = "./modules/vpc"

  project = var.project
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source = "./modules/ec2"

  project = var.project

  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids
  private_subnet_id = module.vpc.private_subnet_ids

  instance_profile_name = module.iam.instance_profile_name
}

module "iam" {
  source = "./modules/ssm"
}

module "eks" {
  source = "./modules/eks"

  project           = var.project
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}
