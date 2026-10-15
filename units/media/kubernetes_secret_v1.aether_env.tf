resource "kubernetes_secret_v1" "aether_env" {
  metadata {
    name      = "aether-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    SERVARR_API_KEY   = random_password.aether_api_key.result
    NCORE_USERNAME    = var.ncore_username
    NCORE_PASSWORD    = var.ncore_password
    TMDB_ACCESS_TOKEN = var.tmdb_access_token
    PLEX_TOKEN        = var.plex_token
  }
}

resource "random_password" "aether_api_key" {
  length  = 16
  special = false
}
