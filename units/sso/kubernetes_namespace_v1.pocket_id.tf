resource "kubernetes_namespace_v1" "pocket_id" {
  metadata {
    name = "pocket-id"
  }
}
