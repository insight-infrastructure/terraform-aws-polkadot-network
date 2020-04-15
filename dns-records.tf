######
# svcs
######
//variable "all_enabled" {
//  description = "Bool to enable all services"
//  type        = bool
//  default     = true
//}
//
//variable "consul_enabled" {
//  description = "Bool to enable consul"
//  type        = bool
//  default     = true
//}

//variable "elb_host_name" {}
//variable "domain_name" {
//  description = "The root domain - leave blank for no dns"
//  type        = string
//  default     = ""
//}


//variable "elasticsearch_enabled" {
//  description = "Bool to enable elasticsearch"
//  type        = bool
//  default     = true
//}
//
//variable "prometheus_enabled" {
//  description = "Bool to enable prometheus"
//  type        = bool
//  default     = true
//}
//
//
//locals {
//  prometheus_enabled    = var.all_enabled ? true : var.prometheus_enabled
//  consul_enabled        = var.all_enabled ? true : var.consul_enabled
//  elasticsearch_enabled = var.all_enabled ? true : var.elasticsearch_enabled
//}

//data "aws_route53_zone" "this" {
//  count = var.domain_name != "" ? 1 : 0
//  name  = "${var.domain_name}."
//}

//// TODO: Move to aws k8s
//resource "aws_route53_record" "prom-record" {
//  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0
//
//  allow_overwrite = true
//  name            = join(".", ["prometheus", var.root_domain_name])
//  ttl             = 30
//  type            = "CNAME"
//  zone_id         = data.aws_route53_zone.this.*.id
//
//  records = [var.elb_host_name]
//}
//
//resource "aws_route53_record" "graf-record" {
//  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0
//
//  allow_overwrite = true
//  name            = join(".", ["grafana", var.root_domain_name])
//  ttl             = 30
//  type            = "CNAME"
//  zone_id         = data.aws_route53_zone.this.*.id
//
//  records = [var.elb_host_name]
//}
//
//resource "aws_route53_record" "alertman-record" {
//  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0
//
//  allow_overwrite = true
//  name            = join(".", ["alertman", var.root_domain_name])
//  ttl             = 30
//  type            = "CNAME"
//  zone_id         = data.aws_route53_zone.this.*.id
//
//  records = [var.elb_host_name]
//}