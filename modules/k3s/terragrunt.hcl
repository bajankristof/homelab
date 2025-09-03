include "secrets" {
  path = find_in_parent_folders("secrets.hcl")
}

dependency "system" {
  config_path = "../system"
}

inputs = {
  kubeconfig_path = dependency.system.outputs.kubeconfig_path
  network_cidr_block = dependency.system.outputs.network_cidr_block
}
