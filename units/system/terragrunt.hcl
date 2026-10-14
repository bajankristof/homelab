include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

inputs = {
  homelab_ip         = include.root.locals.homelab_ip
  homelab_username   = include.root.locals.homelab_username
  homelab_password   = include.root.locals.homelab_password
  tailscale_auth_key = include.root.locals.tailscale_auth_key
}
