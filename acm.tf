//
//module "acm" {
//  source  = "terraform-aws-modules/acm/aws"
//  version = "~> v2.0"
//
//  create_certificate = var.root_domain_name != "" && local.acm_enable ? true : false
//
//  domain_name = local.public_domain
//  zone_id     = join("", aws_route53_zone.region_public.*.zone_id)
//
//  subject_alternative_names = [
//    "*.${local.public_domain}",
//    "*.${join("", aws_route53_zone.region_public.*.name)}",
//  ]
//
//  tags = var.tags
//}
