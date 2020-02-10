locals {
  stuff   = "tihngs"
  vpc_ids = [module.vpc.vpc_id]
}

data "aws_route53_zone" "this" {
  count = var.root_domain_name == "" ? 0 : 1
  name  = "${var.root_domain_name}."
}

resource "aws_route53_zone" "root_private" {
  count = var.create_internal_domain ? 1 : 0
  name  = "${var.namespace}.${var.internal_tld}"

  dynamic "vpc" {
    for_each = local.vpc_ids
    content {
      vpc_id     = vpc.value
      vpc_region = data.aws_region.current.name
    }
  }

  tags = merge(module.label.tags, { "Region" = data.aws_region.current.name, "ZoneType" = "Private" })
}

resource "aws_route53_zone" "region_public" {
  count = var.create_public_regional_subdomain ? 1 : 0

  name = local.public_domain

  tags = merge(module.label.tags, { "Region" = data.aws_region.current.name, "ZoneType" = "PublicRegion" })
}

resource "aws_route53_record" "region_public" {
  count = var.create_public_regional_subdomain ? 1 : 0

  zone_id = var.zone_id == "" ? data.aws_route53_zone.this.*.id[0] : var.zone_id

  name = local.public_domain
  type = "NS"
  ttl  = "30"

  records = [
    aws_route53_zone.region_public.*.name_servers.0[count.index],
    aws_route53_zone.region_public.*.name_servers.1[count.index],
    aws_route53_zone.region_public.*.name_servers.2[count.index],
    aws_route53_zone.region_public.*.name_servers.3[count.index],
  ]
}

