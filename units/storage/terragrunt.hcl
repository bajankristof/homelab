include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "system" {
  config_path = "../system"
}

dependencies {
  paths = ["../k3s"]
}

inputs = {
  homelab_ip = dependency.system.outputs.homelab_ip
  network_cidr_block = dependency.system.outputs.network_cidr_block
}
