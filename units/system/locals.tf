locals {
  network_cidr_block = replace(var.homelab_ip, "/\\.\\d+$/", ".0/24")
}
