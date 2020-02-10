
terraform {
  required_version = ">= 0.12"
}

locals {
  public_domain = join(".", [data.aws_region.current.name, var.environment, var.root_domain_name])
}

data "aws_region" "current" {}

module "label" {
  source = "github.com/robc-io/terraform-null-label.git?ref=0.16.1"
  tags = {
    NetworkName = var.network_name
    Owner       = var.owner
    Terraform   = true
    VpcType     = "main"
  }

  environment = var.environment
  namespace   = var.namespace
  stage       = var.stage
}
