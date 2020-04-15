variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  version = "~> 2.0"
}

module "network" {
  source = "../.."
}
