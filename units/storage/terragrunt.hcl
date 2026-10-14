include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//storage"
}

dependency "system" {
  config_path = "../system"
}

dependencies {
  paths = ["../k3s"]
}
