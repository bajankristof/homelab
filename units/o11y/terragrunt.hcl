include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

terraform {
  source = "${get_repo_root()}/units//o11y"
}

dependency "sso" {
  config_path = "../sso"
}

dependency "platform" {
  config_path = "../platform"
}

inputs = {
  storage_class_name     = dependency.platform.outputs.storage_class_name
  pocket_id_base_url     = dependency.sso.outputs.base_url
  pocket_id_api_key      = dependency.sso.outputs.api_key
  grafana_hostname       = include.root.locals.grafana_hostname
  grafana_base_url       = include.root.locals.grafana_base_url
  grafana_mcp_hostname   = include.root.locals.grafana_mcp_hostname
  grafana_mcp_base_url   = include.root.locals.grafana_mcp_base_url
  grafana_admin_username = include.root.locals.homelab_username
  oidc_auth_url          = dependency.sso.outputs.auth_url
  oidc_token_url         = dependency.sso.outputs.token_url
  oidc_userinfo_url      = dependency.sso.outputs.userinfo_url
  smtp_host              = include.root.locals.smtp_host
  smtp_port              = include.root.locals.smtp_port
  smtp_username          = include.root.locals.smtp_username
  smtp_password          = include.root.locals.smtp_password
  smtp_from_address      = "grafana@${include.root.locals.cloudflare_tld}"
}
