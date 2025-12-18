resource "kubernetes_config_map_v1" "pocket_id_env" {
  metadata {
    name = "pocket-id-env"
  }

  data = {
    APP_NAME    = var.cloudflare_tld
    DB_PROVIDER = "postgres"
  }

  immutable = true
}
