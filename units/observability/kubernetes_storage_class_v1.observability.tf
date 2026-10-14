resource "kubernetes_storage_class_v1" "observability" {
  metadata {
    name = "observability-hostpath"
  }

  storage_provisioner = "kubernetes.io/no-provisioner"
  reclaim_policy      = "Retain"
  volume_binding_mode = "Immediate"
}
