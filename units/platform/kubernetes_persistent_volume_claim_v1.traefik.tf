resource "kubernetes_persistent_volume_claim_v1" "traefik" {
  metadata {
    name      = "data"
    namespace = kubernetes_namespace_v1.traefik.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.default.metadata[0].name

    resources {
      requests = {
        storage = "128Mi"
      }
    }
  }

  wait_until_bound = false
}
