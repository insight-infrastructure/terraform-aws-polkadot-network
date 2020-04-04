
module "hids_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.hids_sg_name
  description = "All traffic"

  create = local.hids_enabled
  vpc_id = module.vpc.vpc_id
  tags = merge({
    Name : var.hids_sg_name
  }, module.label.tags)

  egress_with_cidr_blocks = [{
    from_port   = 0
    to_port     = 65535
    protocol    = -1
    description = "Egress access open to all"
    cidr_blocks = "0.0.0.0/0"
  }, ]

  ingress_with_cidr_blocks = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "http ingress"
    cidr_blocks = "0.0.0.0/0" # TODO: Fix this
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Security group for ssh access from coporate ip"
      cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : "${var.corporate_ip}/32"
  }]

  //  HIDS has two variants that we use, ossec and wazuh.  Wazuh integrates with elasticsearch so we use that exporter for monitoring
  ingress_with_source_security_group_id = concat(
    var.monitoring_enabled ? [{
      from_port                = 9100
      to_port                  = 9100
      protocol                 = "tcp"
      description              = "Node exporter"
      source_security_group_id = module.monitoring_sg.this_security_group_id
      }, {
      from_port                = 9108
      to_port                  = 9108
      protocol                 = "tcp"
      description              = "elasticsearch_exporter"
      source_security_group_id = module.monitoring_sg.this_security_group_id
      }] : [], var.bastion_enabled ? [{
      rule                     = "ssh-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
  }] : [], )

  ingress_cidr_blocks = var.consul_enabled ? [module.vpc.vpc_cidr_block] : []
  ingress_rules       = var.consul_enabled ? ["consul-tcp", "consul-serf-wan-tcp", "consul-serf-wan-udp", "consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-dns-tcp", "consul-dns-udp"] : []
}
