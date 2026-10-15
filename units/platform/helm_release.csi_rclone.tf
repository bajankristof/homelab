resource "helm_release" "csi_rclone" {
  name       = "csi-rclone"
  repository = "oci://ghcr.io/veloxpack/charts"
  chart      = "csi-driver-rclone"
  version    = "0.5.0"
  namespace  = kubernetes_namespace_v1.csi_rclone.metadata[0].name
  atomic     = true
}
