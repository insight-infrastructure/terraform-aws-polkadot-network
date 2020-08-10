locals {
  vpc_ids = [module.vpc.vpc_id]
  # Preserving some old patterns with a little override logic
  # Useful for geo-routing. Otherwise just leave all domain vars
  # except for root domain blank
  subdomain = var.subdomain == "" ? join(".", compact(["aws", var.network_name, var.namespace])) : var.subdomain

  domain = join(".", compact([local.subdomain, var.root_domain_name]))

  public_root   = var.subdomain == "" ? join(".", compact([local.subdomain, var.root_domain_name])) : var.root_domain_name
  public_domain = var.subdomain == "" ? join(".", [data.aws_region.current.name, local.public_root]) : join(".", [var.subdomain, local.public_root])
}

data cloudflare_zones "this" {
  count = local.cloudflare_enable ? 1 : 0
  filter {
    name = var.root_domain_name
  }
}
//
resource "cloudflare_record" "public_delegation" {
  count = local.cloudflare_enable ? 4 : 0

  name    = local.public_domain
  value   = flatten(aws_route53_zone.region_public[0].name_servers)[count.index]
  type    = "NS"
  zone_id = data.cloudflare_zones.this.*.zones[0][0].id
}

//resource "aws_route53_zone" "this" {
//  count         = var.root_domain_name == "" ? 0 : 1
//  name          = "${local.public_root}."
//  force_destroy = true
//}

resource "aws_route53_zone" "region_public" {
  //  count = local.create_public_regional_subdomain ? 1 : 0
  count = 1

  name          = "${local.public_domain}."
  force_destroy = true

  tags = merge(var.tags, { "Region" = data.aws_region.current.name, "ZoneType" = "PublicRegion" })
}

//resource "aws_route53_record" "region_public" {
//  count = local.create_public_regional_subdomain ? 1 : 0
//
//  zone_id = var.zone_id == "" ? join("", aws_route53_zone.this.*.id) : var.zone_id
//
//  name = local.public_domain
//  type = "NS"
//  ttl  = "30"
//
//  records = [
//    aws_route53_zone.region_public.*.name_servers.0[count.index],
//    aws_route53_zone.region_public.*.name_servers.1[count.index],
//    aws_route53_zone.region_public.*.name_servers.2[count.index],
//    aws_route53_zone.region_public.*.name_servers.3[count.index],
//  ]
//}

resource "aws_route53_zone" "root_private" {
  //  count = local.create_internal_domain ? 1 : 0
  count = var.root_domain_name == "" ? 0 : 1
  name  = "${var.namespace}.${var.internal_tld}."

  force_destroy = true

  dynamic "vpc" {
    for_each = local.vpc_ids
    content {
      vpc_id     = vpc.value
      vpc_region = data.aws_region.current.name
    }
  }

  tags = merge(var.tags, { "Region" = data.aws_region.current.name, "ZoneType" = "Private" })
}