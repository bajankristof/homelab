data "kubernetes_service" "postgres" {
  depends_on = [helm_release.postgres]

  metadata {
    name = "postgres"
  }
}
