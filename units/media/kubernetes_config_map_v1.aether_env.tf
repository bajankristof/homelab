resource "kubernetes_config_map_v1" "aether_env" {
  metadata {
    name      = "aether-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    TZ                   = "Europe/Budapest"
    LOG_LEVEL            = "debug-1"
    LOG_FORMAT           = "json"
    PLEX_URL             = "http://plex:32400"
    VIRTUALFS_MOUNT_PATH = "/media/aether"
    CACHE_STORE_MAX_SIZE = var.aether_cache_limit
    TORRENT_LISTEN_PORT  = "42069"

    OTEL_SERVICE_NAME                   = "aether"
    OTEL_METRICS_EXPORTER               = "otlp"
    OTEL_EXPORTER_OTLP_PROTOCOL         = var.otlp_metrics_protocol
    OTEL_EXPORTER_OTLP_METRICS_ENDPOINT = var.otlp_metrics_endpoint
  }

  immutable = false
}
