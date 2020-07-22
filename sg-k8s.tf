module "k8s_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.k8s_sg_name
  description = "k8s workers traffic"

  create = local.k8s_enabled
  vpc_id = module.vpc.vpc_id
  tags = merge({
    Name : var.k8s_sg_name
  }, var.tags)

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Egress access open to all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  ingress_cidr_blocks = [
  "0.0.0.0/0"]
  ingress_rules = [
    "https-443-tcp",
  "http-80-tcp"]
}