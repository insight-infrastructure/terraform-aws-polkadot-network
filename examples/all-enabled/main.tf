
module "network" {
  source      = "../.."
  all_enabled = true
}

output "k8s_sg_id" {
  value = module.network.k8s_security_group_id
}