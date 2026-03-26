resource "kubernetes_config_map_v1" "seerr_env" {
  metadata {
    name = "seerr-env"
  }

  data = {
    TZ      = "Europe/Budapest"
    DB_TYPE = "postgres"
    DB_HOST = var.postgres_fqdn
    DB_PORT = tostring(var.postgres_port)
    DB_NAME = module.postgres_env["seerr"].database.name
  }

  immutable = true
}
