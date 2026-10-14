resource "kubernetes_config_map_v1" "pocket_id_env" {
  metadata {
    name = "pocket-id-env"
  }

  data = {
    APP_NAME    = var.app_name
    DB_PROVIDER = "postgres"
  }

  immutable = true
}
