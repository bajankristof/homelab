data "kubernetes_service_v1" "victoria_metrics" {
  depends_on = [helm_release.victoria_metrics]

  metadata {
    name      = "victoria-metrics"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
