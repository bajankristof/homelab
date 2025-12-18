resource "kubernetes_secret_v1" "pocket_id_env" {
  metadata {
    name = "pocket-id-env"
  }

  data = {
    DB_CONNECTION_STRING = module.postgres_env["pocket_id"].url
  }
}
