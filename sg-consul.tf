
module "consul_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.consul_sg_name
  description = "All traffic"

  create = local.consul_enabled
  vpc_id = module.vpc.vpc_id
  tags   = merge({ Name : var.consul_sg_name }, module.label.tags)
}

resource "aws_security_group_rule" "consul_egress" {
  count = local.consul_enabled ? 1 : 0

  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = module.monitoring_sg.this_security_group_id
  security_group_id        = module.consul_sg.this_security_group_id
}

resource "aws_security_group_rule" "consul_ssh_bastion" {
  count = local.consul_enabled && local.bastion_enabled ? 1 : 0

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = module.bastion_sg.this_security_group_id
  security_group_id        = module.consul_sg.this_security_group_id
}

resource "aws_security_group_rule" "consul_ssh_public" {
  count = local.consul_enabled && ! local.bastion_enabled ? 1 : 0

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.consul_sg.this_security_group_id
}

############
# Monitoring
############
locals {
  consul_rules_monitoring = [
    [9100, 9100, "tcp", "Node exporter"],
    [9107, 9107, "tcp", "SSH exporter"],
    [9428, 9428, "tcp", "Consul exporter"],
  ]
}


resource "aws_security_group_rule" "consul_rules_monitoring" {
  count = local.consul_enabled && local.monitoring_enabled ? length(local.consul_rules_monitoring) : 0

  security_group_id = module.consul_sg.this_security_group_id
  type              = "ingress"

  source_security_group_id = module.monitoring_sg.this_security_group_id
  description              = local.consul_rules_monitoring[count.index][3]

  from_port = local.consul_rules_monitoring[count.index][0]
  to_port   = local.consul_rules_monitoring[count.index][1]
  protocol  = local.consul_rules_monitoring[count.index][2]
}

########
# Consul
########
locals {
  consul_rules_self = [
    [8300, 8300, "tcp", "Consul server"],
    [8400, 8400, "tcp", "Consul CLI RPC"],
    [8500, 8500, "tcp", "Consul web UI"],
    [8600, 8600, "tcp", "Consul DNS"],
    [8600, 8600, "udp", "Consul DNS"],
    [8301, 8301, "tcp", "Serf LAN"],
    [8301, 8301, "udp", "Serf LAN"],
    [8302, 8302, "tcp", "Serf WAN"],
    [8302, 8302, "udp", "Serf WAN"],
  ]
}

resource "aws_security_group_rule" "consul_rules_self" {
  count = var.consul_enabled ? length(local.consul_rules_self) : 0

  security_group_id = module.consul_sg.this_security_group_id
  type              = "ingress"

  self        = true
  description = local.consul_rules_self[count.index][3]

  from_port = local.consul_rules_self[count.index][0]
  to_port   = local.consul_rules_self[count.index][1]
  protocol  = local.consul_rules_self[count.index][2]
}

//module "consul_rules" {
//  source      = "github.com/robc-io/terraform-aws-security-group.git?ref=v3.1.1"
//  name        = "consul"
//  description = "All traffic"
//
//  create            = local.consul_enabled
//  security_group_id = local.consul_enabled ? module.consul_sg.this_security_group_id : ""
//
//  vpc_id = module.vpc.vpc_id
//
//  ingress_with_cidr_blocks = local.bastion_enabled ? [{
//    from_port   = 22
//    to_port     = 22
//    protocol    = "tcp"
//    description = "Security group for ssh access from coporate ip"
//    cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : "${var.corporate_ip}/32"
//  }] : []
//
//  ingress_with_source_security_group_id = concat(
//    local.monitoring_enabled ? [{
//      from_port                = 9100
//      to_port                  = 9100
//      protocol                 = "tcp"
//      description              = "Node exporter"
//      source_security_group_id = module.monitoring_sg.this_security_group_id
//      }, {
//      from_port                = 9428
//      to_port                  = 9428
//      protocol                 = "tcp"
//      description              = "Nordstrom/ssh_exporter"
//      source_security_group_id = module.monitoring_sg.this_security_group_id
//      }] : [], local.bastion_enabled ? [{
//      rule                     = "ssh-tcp"
//      source_security_group_id = module.bastion_sg.this_security_group_id
//  }] : [], )
//
//  egress_with_cidr_blocks = [{
//    from_port   = 0
//    to_port     = 65535
//    protocol    = -1
//    description = "Egress access open to all"
//    cidr_blocks = "0.0.0.0/0"
//  }, ]
//}



//resource "aws_security_group_rule" "consul_monitoring_consul" {
//  count = local.consul_enabled && local.monitoring_enabled ? 1 : 0
//
//  type = "ingress"
//  protocol = "tcp"
//  from_port = 9107
//  to_port = 9107
//  source_security_group_id = module.monitoring_sg.this_security_group_id
//  security_group_id = module.consul_sg.this_security_group_id
//}
//
//resource "aws_security_group_rule" "consul_monitoring_ssh" {
//  count = local.consul_enabled && local.monitoring_enabled ? 1 : 0
//
//  type = "ingress"
//  protocol = "tcp"
//  from_port = 9428
//  to_port = 9428
//  source_security_group_id = module.monitoring_sg.this_security_group_id
//  security_group_id = module.consul_sg.this_security_group_id
//}