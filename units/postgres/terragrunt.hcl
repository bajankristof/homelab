include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//postgres"
}

dependency "system" {
  config_path = "../system"
}

dependency "platform" {
  config_path = "../platform"
}

inputs = {
  storage_class_name = dependency.platform.outputs.storage_class_name
}
