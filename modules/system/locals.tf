locals {
  network_cidr_block = replace(var.homelab_address, "/\\.\\d+$/", ".0/24")
  kubeconfig_path    = abspath("${path.module}/../../kubeconfig")
}
