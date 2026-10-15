resource "kubernetes_storage_class_v1" "aether" {
  metadata {
    name = "aether"
  }

  storage_provisioner = "rclone.csi.veloxpack.io"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"

  parameters = {
    remote     = "aether"
    remotePath = "/"

    "csi.storage.k8s.io/node-publish-secret-name"      = kubernetes_secret_v1.aether_rclone.metadata[0].name
    "csi.storage.k8s.io/node-publish-secret-namespace" = kubernetes_namespace_v1.this.metadata[0].name
  }

  mount_options = [
    "allow-other",
    "dir-cache-time=1s",
    "poll-interval=0",
    "no-modtime",
    "no-checksum",
    "uid=1000",
    "gid=1000",
  ]
}
