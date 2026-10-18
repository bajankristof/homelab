include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//dashboards"
}

dependency "o11y" {
  config_path = "../o11y"
}

inputs = {
  grafana_base_url       = dependency.o11y.outputs.grafana_base_url
  grafana_admin_username = dependency.o11y.outputs.grafana_admin_username
  grafana_admin_password = dependency.o11y.outputs.grafana_admin_password
}
