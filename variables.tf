variable "cloudflare_enable" {
  description = "Make records in cloudflare"
  type        = bool
  default     = false
}

variable "id" {
  description = "A unique identifier for the deployment"
  type        = string
  default     = ""
}

########
# Label
########
variable "name" {
  description = "The name of the deployment"
  type        = string
  default     = "polkadot-api"
}

variable "tags" {
  description = "The tags of the deployment"
  type        = map(string)
  default     = {}
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
  default     = "polkadot"
}

variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = "kusama"
}

######
# DNS
######

variable "subdomain" {
  description = "The subdomain"
  type        = string
  default     = ""
}

variable "internal_tld" {
  description = "The top level domain for the internal DNS"
  type        = string
  default     = "internal"
}

variable "root_domain_name" {
  description = "The public domain"
  type        = string
  default     = ""
}

variable "create_internal_domain" {
  description = "Boolean to create an internal split horizon DNS"
  type        = bool
  default     = false
}

variable "create_public_regional_subdomain" {
  description = "Boolean to create regional subdomain - ie us-east-1.example.com"
  type        = bool
  default     = false
}

variable "zone_id" {
  description = "The zone ID to configure as the root zoon - ie subdomain.example.com's zone ID"
  type        = string
  default     = ""
}

######
# VPC
######
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = ""
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = []
}

variable "num_azs" {
  description = "The number of AZs to deploy into"
  type        = number
  default     = 0
}

variable "cidr" {
  description = "The cidr range for network"
  type        = string
  default     = "10.0.0.0/16"
}

//variable "cluster_name" {
//  description = "k8s cluster name - blank gets random pet"
//  type        = string
//  default     = ""
//}

##################
# Security Groups
##################
variable "all_enabled" {
  description = "Bool to enable all the security groups"
  type        = bool
  default     = false
}

variable "corporate_ip" {
  description = "The corporate IP you want to restrict ssh traffic to"
  type        = string
  default     = ""
}

variable "bastion_enabled" {
  description = "Boolean to enable a bastion host.  All ssh traffic restricted to bastion"
  type        = bool
  default     = false
}

variable "consul_enabled" {
  description = "Boolean to allow consul traffic"
  type        = bool
  default     = false
}

variable "hids_enabled" {
  description = "Boolean to enable intrusion detection systems traffic"
  type        = bool
  default     = false
}

variable "k8s_enabled" {
  description = "Boolean to enable kubernetes"
  type        = bool
  default     = false
}

variable "logging_enabled" {
  description = "Boolean to allow logging related traffic"
  type        = bool
  default     = false
}

variable "monitoring_enabled" {
  description = "Boolean to for prometheus related traffic"
  type        = bool
  default     = false
}

variable "sentry_enabled" {
  description = "Boolean to allow sentry related traffic"
  type        = bool
  default     = false
}

variable "api_enabled" {
  description = "Boolean to allow api related traffic"
  type        = bool
  default     = false
}

variable "validator_enabled" {
  description = "Boolean to allow validator related traffic"
  type        = bool
  default     = false
}

variable "sentry_sg_name" {
  description = "Name for the public node security group"
  type        = string
  default     = "sentry-sg"
}

variable "bastion_sg_name" {
  description = "Name for the bastion security group"
  type        = string
  default     = "bastion-sg"
}

variable "consul_sg_name" {
  description = "Name for the consult security group"
  type        = string
  default     = "consul-sg"
}

variable "k8s_sg_name" {
  description = "Name for the consult security group"
  type        = string
  default     = "k8s-sg"
}

variable "monitoring_sg_name" {
  description = "Name for the monitoring security group"
  type        = string
  default     = "monitoring-sg"
}

variable "hids_sg_name" {
  description = "Name for the HIDS security group"
  type        = string
  default     = "hids-sg"
}

variable "logging_sg_name" {
  description = "Name for the logging security group"
  type        = string
  default     = "logging-sg"
}

variable "api_sg_name" {
  description = "Name for the api security group"
  type        = string
  default     = "api-sg"
}

variable "validator_sg_name" {
  description = "Name for the validator security group"
  type        = string
  default     = "validator-sg"
}