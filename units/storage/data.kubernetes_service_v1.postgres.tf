data "kubernetes_service_v1" "postgres" {
  depends_on = [helm_release.postgres]

  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }
}
