module "vpc" {
  source = "/Users/museongkweon/Desktop/Career-Develop/Toy-Project/terraform-aws-iac/modules/vpc"

  project = var.project
  vpc_cidr = var.vpc_cidr
}

module "ec2" {
  source = "/Users/museongkweon/Desktop/Career-Develop/Toy-Project/terraform-aws-iac/modules/ec2"

  project = var.project

  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id

  instance_profile_name = module.iam.instance_profile_name
}

module "iam" {
  source = "/Users/museongkweon/Desktop/Career-Develop/Toy-Project/terraform-aws-iac/modules/iam"
}
