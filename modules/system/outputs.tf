output "homelab_address" {
  value = var.homelab_address
}

output "network_cidr_block" {
  value = local.network_cidr_block
}

output "kubeconfig_path" {
  value = local.kubeconfig_path
}
