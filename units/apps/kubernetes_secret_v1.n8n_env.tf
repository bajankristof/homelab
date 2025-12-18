resource "kubernetes_secret_v1" "n8n_env" {
  metadata {
    name = "n8n-env"
  }

  data = {
    DB_POSTGRESDB_USER     = module.postgres_env["n8n"].role.name
    DB_POSTGRESDB_PASSWORD = module.postgres_env["n8n"].password
  }
}
