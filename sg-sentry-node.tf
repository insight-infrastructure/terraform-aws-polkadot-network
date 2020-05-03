module "sentry_node_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.sentry_node_sg_name
  description = "All traffic"

  create = local.sentry_enabled

  vpc_id = module.vpc.vpc_id
  tags = merge({
    Name : var.sentry_node_sg_name
  }, module.label.tags)

  ingress_with_source_security_group_id = concat(local.bastion_enabled ? [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
    }] : [], local.monitoring_enabled ? [
    {
      from_port                = 9100
      to_port                  = 9100
      protocol                 = "tcp"
      description              = "Node exporter"
      source_security_group_id = module.monitoring_sg.this_security_group_id
    },
    {
      from_port                = 9610
      to_port                  = 9610
      protocol                 = "tcp"
      description              = "Client exporter"
      source_security_group_id = module.monitoring_sg.this_security_group_id
    },
    {
      from_port                = 9323
      to_port                  = 9323
      protocol                 = "tcp"
      description              = "Docker Prometheus Metrics under /metrics endpoint"
      source_security_group_id = module.monitoring_sg.this_security_group_id
    }] : [], local.hids_enabled ? [
    {
      from_port                = 1514
      to_port                  = 1515
      protocol                 = "tcp"
      description              = "wazuh agent ports for "
      source_security_group_id = module.monitoring_sg.this_security_group_id
  }] : [])

  ingress_cidr_blocks = local.consul_enabled ? [
  module.vpc.vpc_cidr_block] : []
  ingress_rules = local.consul_enabled ? [
    "consul-tcp",
    "consul-serf-wan-tcp",
    "consul-serf-wan-udp",
    "consul-serf-lan-tcp",
    "consul-serf-lan-udp",
    "consul-dns-tcp",
  "consul-dns-udp"] : []

  ingress_with_cidr_blocks = concat(
    [
      {
        from_port   = 30333
        to_port     = 30333
        protocol    = "tcp"
        description = ""
        cidr_blocks = "0.0.0.0/0"
      },
      {
        from_port   = 51820
        to_port     = 51820
        protocol    = "udp"
        description = ""
        cidr_blocks = "0.0.0.0/0"
      },
      {
        from_port   = 5500
        to_port     = 5500
        protocol    = "tcp"
        description = ""
        cidr_blocks = "0.0.0.0/0"
      },
      {
        from_port   = 9933
        to_port     = 9933
        protocol    = "tcp"
        description = ""
        cidr_blocks = "0.0.0.0/0"
      },
    ], local.bastion_enabled ? [] :
    [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "Security group for ssh access from coporate ip"
        cidr_blocks = var.corporate_ip == "" ? "0.0.0.0/0" : "${var.corporate_ip}/32"
  }], )

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = -1
      description = "Egress access open to all"
      cidr_blocks = "0.0.0.0/0"
  }, ]
}
