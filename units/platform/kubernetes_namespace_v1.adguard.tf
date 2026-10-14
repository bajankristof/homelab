resource "kubernetes_namespace_v1" "adguard" {
  metadata {
    name = "adguard"
  }
}
