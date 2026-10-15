resource "kubernetes_namespace_v1" "csi_rclone" {
  metadata {
    name = "csi-rclone"
  }
}
