output "homelab_ip" {
  value = var.homelab_ip
}

output "network_cidr_block" {
  value = local.network_cidr_block
}

output "kubeconfig_path" {
  value = local.kubeconfig_path
}
