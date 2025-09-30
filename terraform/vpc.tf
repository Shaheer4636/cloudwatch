# Corporate VPC module from the 'vpc' repo the pipeline checks out
module "vpc" {
  source           = "../vpc"

  name             = local.name
  cidr             = var.vpccidr
  azs              = var.azs
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets
  public_subnets   = local.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags
}
