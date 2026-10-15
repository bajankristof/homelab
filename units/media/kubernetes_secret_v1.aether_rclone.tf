resource "kubernetes_secret_v1" "aether_rclone" {
  metadata {
    name      = "aether-rclone"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    remote     = "aether"
    remotePath = "/"
    configData = <<-EOT
      [aether]
      type = webdav
      url = http://aether.${kubernetes_namespace_v1.this.metadata[0].name}.svc.cluster.local:8080/vfs
      vendor = other
    EOT
  }
}
