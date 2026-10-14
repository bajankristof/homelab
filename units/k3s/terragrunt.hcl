include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//k3s"
}

dependency "system" {
  config_path = "../system"
}

inputs = {
  network_cidr_block = dependency.system.outputs.network_cidr_block

  traefik_hostname = include.root.locals.traefik_hostname

  cloudflare_dns_api_token = include.root.locals.cloudflare_dns_api_token
  acme_email               = include.root.locals.acme_email
}
