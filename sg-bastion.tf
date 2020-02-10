
module "bastion_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.bastion_sg_name
  description = "All traffic"

  create = var.bastion_enabled
  vpc_id = module.vpc.vpc_id
  tags   = merge({ Name : var.bastion_sg_name }, module.label.tags)
}

module "bastion_rules" {
  source      = "github.com/robc-io/terraform-aws-security-group.git?ref=v3.1.1"
  name        = "bastion"
  description = "All traffic"

  create            = var.bastion_enabled
  security_group_id = var.bastion_enabled ? module.bastion_sg.this_security_group_id : ""

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = var.bastion_enabled ? [{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Security group for ssh access from coporate ip"
    cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : "${var.corporate_ip}/32"
  }] : []

  ingress_with_source_security_group_id = var.monitoring_enabled ? [{
    from_port                = 9100
    to_port                  = 9100
    protocol                 = "tcp"
    description              = "Node exporter"
    source_security_group_id = module.monitoring_sg.this_security_group_id
    }, {
    from_port                = 9428
    to_port                  = 9428
    protocol                 = "tcp"
    description              = "Nordstrom/ssh_exporter"
    source_security_group_id = module.monitoring_sg.this_security_group_id
  }] : []

  egress_with_cidr_blocks = [{
    from_port   = 0
    to_port     = 65535
    protocol    = -1
    description = "Egress access open to all"
    cidr_blocks = "0.0.0.0/0"
  }, ]
}