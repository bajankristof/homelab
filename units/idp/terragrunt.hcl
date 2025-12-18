include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "system" {
  config_path = "../system"
}

dependency "storage" {
  config_path = "../storage"
}

inputs = {
  homelab_ip = dependency.system.outputs.homelab_ip
  network_cidr_block = dependency.system.outputs.network_cidr_block
  kubeconfig_path = dependency.system.outputs.kubeconfig_path
  postgres_fqdn = dependency.storage.outputs.postgres_fqdn
  postgres_port = dependency.storage.outputs.postgres_port
  postgres_node_port = dependency.storage.outputs.postgres_node_port
  postgres_root_user = dependency.storage.outputs.postgres_root_user
  postgres_root_password = dependency.storage.outputs.postgres_root_password
}
