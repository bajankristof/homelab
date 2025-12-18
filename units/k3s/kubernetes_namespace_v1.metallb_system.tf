resource "kubernetes_namespace_v1" "metallb_system" {
  metadata {
    name = "metallb-system"
  }
}
