variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  version = "~> 2.0"
}

data "aws_caller_identity" "this" {}

variable "root_domain_name" {}

resource "random_pet" "this" {}

module "network" {
  source               = "../.."
  all_enabled          = true
  root_domain_name     = var.root_domain_name
  create_bastion       = true
  bucket_force_destroy = true
  bucket_name          = "logs-${data.aws_caller_identity.this.account_id}-${random_pet.this.id}"
}

output "k8s_sg_id" {
  value = module.network.k8s_security_group_id
}