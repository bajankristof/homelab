include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//apps"
}

dependency "system" {
  config_path = "../system"
}

dependency "storage" {
  config_path = "../storage"
}

dependency "idp" {
  config_path = "../idp"
}

inputs = {
  plex_host_ip           = cidrhost(dependency.system.outputs.network_cidr_block, 2)
  plex_hostname          = include.root.locals.plex_hostname
  seerr_hostname         = include.root.locals.seerr_hostname
  postgres_fqdn          = dependency.storage.outputs.postgres_fqdn
  postgres_port          = dependency.storage.outputs.postgres_port
  postgres_node_ip       = dependency.system.outputs.homelab_ip
  postgres_node_port     = dependency.storage.outputs.postgres_node_port
  postgres_root_user     = dependency.storage.outputs.postgres_root_user
  postgres_root_password = dependency.storage.outputs.postgres_root_password
}
