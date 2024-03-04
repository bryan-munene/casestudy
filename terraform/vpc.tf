module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = var.subnets.azs
  private_subnets = var.subnets.private_subnets
  public_subnets  = var.subnets.public_subnets

  enable_nat_gateway = true

  tags = var.tags
}