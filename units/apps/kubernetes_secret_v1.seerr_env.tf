resource "kubernetes_secret_v1" "seerr_env" {
  metadata {
    name = "seerr-env"
  }

  data = {
    DB_USER = module.postgres_env["seerr"].role.name
    DB_PASS = module.postgres_env["seerr"].password
  }
}
