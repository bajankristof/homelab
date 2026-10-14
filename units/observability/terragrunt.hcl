include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//observability"
}

dependency "idp" {
  config_path = "../idp"
}

dependency "oidc" {
  config_path = "../oidc"
}

dependencies {
  paths = ["../k3s"]
}

inputs = {
  grafana_hostname           = include.root.locals.grafana_hostname
  grafana_base_url           = include.root.locals.grafana_base_url
  grafana_admin_username     = include.root.locals.homelab_username
  grafana_oidc_client_id     = dependency.oidc.outputs.grafana_client_id
  grafana_oidc_client_secret = dependency.oidc.outputs.grafana_client_secret
  oidc_auth_url              = dependency.idp.outputs.auth_url
  oidc_token_url             = dependency.idp.outputs.token_url
  oidc_userinfo_url          = dependency.idp.outputs.userinfo_url
  smtp_host                  = include.root.locals.smtp_host
  smtp_port                  = include.root.locals.smtp_port
  smtp_username              = include.root.locals.smtp_username
  smtp_password              = include.root.locals.smtp_password
  smtp_from_address          = "grafana@${include.root.locals.cloudflare_tld}"
}
