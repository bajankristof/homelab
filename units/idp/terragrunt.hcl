include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//idp"
}

dependency "system" {
  config_path = "../system"
}

dependency "storage" {
  config_path = "../storage"
}

inputs = {
  app_name               = include.root.locals.cloudflare_tld
  hostname               = include.root.locals.pocket_id_hostname
  postgres_fqdn          = dependency.storage.outputs.postgres_fqdn
  postgres_port          = dependency.storage.outputs.postgres_port
  postgres_node_ip       = dependency.system.outputs.homelab_ip
  postgres_node_port     = dependency.storage.outputs.postgres_node_port
  postgres_root_user     = dependency.storage.outputs.postgres_root_user
  postgres_root_password = dependency.storage.outputs.postgres_root_password
}
