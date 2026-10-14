include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//media"
}

dependency "system" {
  config_path = "../system"
}

dependency "postgres" {
  config_path = "../postgres"
}

dependency "sso" {
  config_path = "../sso"
}

dependency "platform" {
  config_path = "../platform"
}

inputs = {
  storage_class_name     = dependency.platform.outputs.storage_class_name
  plex_host_ip           = cidrhost(dependency.system.outputs.network_cidr_block, 2)
  plex_hostname          = include.root.locals.plex_hostname
  seerr_hostname         = include.root.locals.seerr_hostname
  postgres_fqdn          = dependency.postgres.outputs.fqdn
  postgres_port          = dependency.postgres.outputs.port
  postgres_node_ip       = dependency.system.outputs.homelab_ip
  postgres_node_port     = dependency.postgres.outputs.node_port
  postgres_root_user     = dependency.postgres.outputs.root_user
  postgres_root_password = dependency.postgres.outputs.root_password
}
