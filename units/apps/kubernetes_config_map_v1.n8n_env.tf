resource "kubernetes_config_map_v1" "n8n_env" {
  metadata {
    name = "n8n-env"
  }

  data = {
    DB_TYPE                = "postgresdb"
    DB_POSTGRESDB_HOST     = var.postgres_fqdn
    DB_POSTGRESDB_PORT     = tostring(var.postgres_port)
    DB_POSTGRESDB_DATABASE = module.postgres_env["n8n"].database.name
  }

  immutable = true
}
