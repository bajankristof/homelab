resource "kubernetes_namespace_v1" "metallb" {
  metadata {
    name = "metallb"
  }
}
