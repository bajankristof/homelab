resource "kubernetes_config_map_v1" "aether_env" {
  metadata {
    name      = "aether-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    TZ                   = "Europe/Budapest"
    PLEX_URL             = "http://plex:32400"
    VIRTUALFS_MOUNT_PATH = "/media/aether"
    CACHE_STORE_MAX_SIZE = var.aether_cache_limit
  }

  immutable = false
}
