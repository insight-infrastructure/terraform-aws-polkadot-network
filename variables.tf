#######
# Label
#######
variable "environment" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = ""
}

variable "stage" {
  type    = string
  default = ""
}

variable "network_name" {
  type    = string
  default = ""
}

variable "owner" {
  type    = string
  default = ""
}

#####
# DNS
#####
variable "internal_tld" {
  type    = string
  default = "internal"
}

variable "root_domain_name" {
  type    = string
  default = ""
}

variable "create_internal_domain" {
  type    = bool
  default = false
}

variable "create_public_regional_subdomain" {
  type    = bool
  default = false
}

variable "zone_id" {
  type    = string
  default = ""
}

#####
# VPC
#####
variable "vpc_name" {
  type    = string
  default = ""
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#################
# Security Groups
#################

variable "corporate_ip" {
  type    = string
  default = ""
}

variable "bastion_enabled" {
  type    = bool
  default = false
}

variable "consul_enabled" {
  type    = bool
  default = false
}

variable "monitoring_enabled" {
  type    = bool
  default = false
}

variable "hids_enabled" {
  type    = bool
  default = false
}
variable "logging_enabled" {
  type    = bool
  default = false
}
variable "vault_enabled" {
  type    = bool
  default = false
}

variable "public_node_sg_name" {
  type    = string
  default = "public-sg"
}

variable "bastion_sg_name" {
  type    = string
  default = "bastion-sg"
}

variable "consul_sg_name" {
  type    = string
  default = "consul-sg"
}

variable "monitoring_sg_name" {
  type    = string
  default = "monitoring-sg"
}

variable "hids_sg_name" {
  type    = string
  default = "hids-sg"
}

variable "logging_sg_name" {
  type    = string
  default = "bastion-sg"
}

variable "vault_sg_name" {
  type    = string
  default = "bastion-sg"
}
