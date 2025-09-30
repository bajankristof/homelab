resource "kubernetes_namespace" "adguard" {
  metadata {
    name = "adguard"
  }
}
