resource "kubernetes_storage_class_v1" "default" {
  metadata {
    name = "host-path"

    annotations = {
      defaultVolumeType = "local"
    }
  }

  storage_provisioner = "rancher.io/local-path"
  reclaim_policy      = "Retain"
  volume_binding_mode = "WaitForFirstConsumer"

  parameters = {
    pathPattern            = "{{ if eq .PVC.Namespace \"default\" }}{{ .PVC.Name }}{{ else }}{{ .PVC.Namespace }}/{{ .PVC.Name }}{{ end }}"
    allowUnsafePathPattern = "true"
  }
}
