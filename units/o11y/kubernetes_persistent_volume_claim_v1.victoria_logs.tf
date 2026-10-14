resource "kubernetes_persistent_volume_claim_v1" "victoria_logs" {
  metadata {
    name      = "victoria-logs"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = var.storage_class_name

    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }

  wait_until_bound = false
}
