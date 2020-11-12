module "api_node_sg" {
  source      = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.2.0"
  name        = var.api_sg_name
  description = "All traffic"

  create = local.api_enabled

  vpc_id = module.vpc.vpc_id
  tags = merge({
    Name : var.api_sg_name
  }, var.tags)

  ingress_with_source_security_group_id = concat(local.bastion_enabled ? [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
      }] : [], local.monitoring_enabled ? concat([
      # static rules
      {
        from_port                = 9100
        to_port                  = 9100
        protocol                 = "tcp"
        description              = "Node exporter"
        source_security_group_id = module.monitoring_sg.this_security_group_id
      },
      {
        from_port                = 9323
        to_port                  = 9323
        protocol                 = "tcp"
        description              = "Docker Prometheus Metrics under /metrics endpoint"
        source_security_group_id = module.monitoring_sg.this_security_group_id
      }], [
      # dynamic rules based on Polkadot network
      for network in var.polkadot_network_settings : {
        from_port                = network["polkadot_prometheus"]
        to_port                  = network["polkadot_prometheus"]
        protocol                 = "tcp"
        description              = "Client exporter - ${network["name"]}"
        source_security_group_id = module.monitoring_sg.this_security_group_id
      }
    ]) : [], local.hids_enabled ? [
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
    concat(
      # static rules
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
        ], [
        # dynamic rules based on Polkadot network
        for network in var.polkadot_network_settings : {
          from_port   = network["api_health"]
          to_port     = network["api_health"]
          protocol    = "tcp"
          description = "Health Check - ${network["name"]}"
          cidr_blocks = "0.0.0.0/0"
      }],
      [
        for network in var.polkadot_network_settings : {
          from_port   = network["json_rpc"]
          to_port     = network["json_rpc"]
          protocol    = "tcp"
          description = "JSON RPC - ${network["name"]}"
          cidr_blocks = "0.0.0.0/0"
      }],
      [
        for network in var.polkadot_network_settings : {
          from_port   = network["ws_rpc"]
          to_port     = network["ws_rpc"]
          protocol    = "tcp"
          description = "WS RPC - ${network["name"]}"
          cidr_blocks = "0.0.0.0/0"
      }],
    ), local.bastion_enabled ? [] :
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
