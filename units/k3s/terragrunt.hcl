include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "system" {
  config_path = "../system"
}

inputs = {
  homelab_ip = dependency.system.outputs.homelab_ip
  network_cidr_block = dependency.system.outputs.network_cidr_block
  kubeconfig_path = dependency.system.outputs.kubeconfig_path
}
