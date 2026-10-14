include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//sso"
}

dependency "system" {
  config_path = "../system"
}

dependency "postgres" {
  config_path = "../postgres"
}

inputs = {
  app_name               = include.root.locals.cloudflare_tld
  hostname               = include.root.locals.pocket_id_hostname
  postgres_fqdn          = dependency.postgres.outputs.fqdn
  postgres_port          = dependency.postgres.outputs.port
  postgres_node_ip       = dependency.system.outputs.homelab_ip
  postgres_node_port     = dependency.postgres.outputs.node_port
  postgres_root_user     = dependency.postgres.outputs.root_user
  postgres_root_password = dependency.postgres.outputs.root_password
}
