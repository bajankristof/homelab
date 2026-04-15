include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "secrets" {
  path = find_in_parent_folders("secrets.hcl")
}
