data "kubernetes_service_v1" "this" {
  depends_on = [helm_release.this]

  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
