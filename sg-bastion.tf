
module "bastion_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.bastion_sg_name
  description = "All traffic"

  create = local.bastion_enabled
  vpc_id = module.vpc.vpc_id
  tags   = merge({ Name : var.bastion_sg_name }, var.tags)
}

resource "aws_security_group_rule" "bastion-ssh" {
  count             = local.bastion_enabled ? 1 : 0
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.this_security_group_id
}
