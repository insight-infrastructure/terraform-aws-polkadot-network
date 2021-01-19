variable "aws_region" {
  default = "us-east-1"
}

//provider "cloudflare" {}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../.."
}
