variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  version = "~> 2.0"
}

variable "root_domain_name" {}

module "network" {
  source           = "../.."
  all_enabled      = true
  root_domain_name = var.root_domain_name
}

output "k8s_sg_id" {
  value = module.network.k8s_security_group_id
}