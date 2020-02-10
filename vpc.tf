
module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
  name   = var.vpc_name

  tags = module.label.tags

  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  azs = var.azs

  cidr = "10.0.0.0/16"

  //  private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  //  public_subnets = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]

  private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  public_subnets  = ["10.0.192.0/24", "10.0.193.0/24", "10.0.194.0/24"]
}
