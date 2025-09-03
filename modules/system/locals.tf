locals {
  network_cidr_block = replace(var.host, "/\\.\\d+$/", ".0/24")
  kubeconfig_path    = abspath("${path.module}/../../kubeconfig")
}
