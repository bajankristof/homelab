resource "kubernetes_persistent_volume_v1" "media" {
  metadata {
    name = "media"
  }

  spec {
    capacity = {
      storage = "2Ti"
    }

    access_modes                     = ["ReadWriteOnce"]
    storage_class_name               = var.storage_class_name
    persistent_volume_reclaim_policy = "Retain"

    persistent_volume_source {
      host_path {
        path = "/mnt/media"
        type = "DirectoryOrCreate"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "media" {
  metadata {
    name      = "media"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = var.storage_class_name
    volume_name        = kubernetes_persistent_volume_v1.media.metadata[0].name

    resources {
      requests = {
        storage = "2Ti"
      }
    }
  }

  wait_until_bound = false
}
