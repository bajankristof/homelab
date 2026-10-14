resource "kubernetes_persistent_volume_v1" "victoria_logs" {
  metadata {
    name = "victoria-logs"
  }

  spec {
    capacity = {
      storage = var.victoria_logs_storage_limit
    }

    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = kubernetes_storage_class_v1.observability.metadata[0].name
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      host_path {
        path = "/mnt/victoria/logs"
        type = "DirectoryOrCreate"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "victoria_logs" {
  metadata {
    name      = "victoria-logs"
    namespace = kubernetes_namespace_v1.observability.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.observability.metadata[0].name
    volume_name        = kubernetes_persistent_volume_v1.victoria_logs.metadata[0].name

    resources {
      requests = {
        storage = var.victoria_logs_storage_limit
      }
    }
  }
}
