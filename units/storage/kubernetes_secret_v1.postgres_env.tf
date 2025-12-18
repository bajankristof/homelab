resource "kubernetes_secret_v1" "postgres_env" {
  metadata {
    name      = "postgres-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    POSTGRES_PASSWORD = random_password.postgres.result
  }
}
