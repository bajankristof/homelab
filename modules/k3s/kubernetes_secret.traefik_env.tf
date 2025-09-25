resource "kubernetes_secret" "traefik_env" {
  depends_on = [kubernetes_namespace.traefik]

  metadata {
    name      = "traefik-env"
    namespace = kubernetes_namespace.traefik.metadata[0].name
  }

  type = "Opaque"

  data = {
    CLOUDFLARE_DNS_API_TOKEN = var.cloudflare_dns_api_token
  }
}
