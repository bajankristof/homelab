include "secrets" {
  path = find_in_parent_folders("secrets.hcl")
}

dependency "system" {
  config_path = "../system"
}

dependency "k3s" {
  config_path = "../k3s"
}

inputs = {
  homelab_ip = dependency.system.outputs.homelab_ip
  network_cidr_block = dependency.system.outputs.network_cidr_block
  kubeconfig_path = dependency.system.outputs.kubeconfig_path
  postgres_host   = dependency.k3s.outputs.postgres_host
  postgres_port   = dependency.k3s.outputs.postgres_port
  postgres_node_port = dependency.k3s.outputs.postgres_node_port
  postgres_root_user     = dependency.k3s.outputs.postgres_root_user
  postgres_root_password = dependency.k3s.outputs.postgres_root_password
}
