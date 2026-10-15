data "kubernetes_service_v1" "grafana" {
  depends_on = [helm_release.grafana]

  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
