include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "idp" {
  config_path = "../idp"
}

inputs = {
  pocket_id_url = dependency.idp.outputs.url
  pocket_id_api_key = dependency.idp.outputs.api_key
}
