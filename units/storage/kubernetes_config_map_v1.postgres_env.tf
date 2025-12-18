resource "kubernetes_config_map_v1" "postgres_env" {
  metadata {
    name      = "postgres-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    POSTGRES_USER = "postgres"
  }

  immutable = true
}
