data "kubernetes_service_v1" "victoria_logs" {
  depends_on = [helm_release.victoria_logs]

  metadata {
    name      = "victoria-logs"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
