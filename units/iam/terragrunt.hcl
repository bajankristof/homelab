include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

dependency "sso" {
  config_path = "../sso"
}

inputs = {
  pocket_id_base_url = dependency.sso.outputs.base_url
  pocket_id_api_key  = dependency.sso.outputs.api_key
  iam_users          = include.root.locals.iam_users
}
