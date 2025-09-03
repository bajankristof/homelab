resource "kubernetes_namespace" "metallb_system" {
  metadata {
    name = "metallb-system"
  }
}
