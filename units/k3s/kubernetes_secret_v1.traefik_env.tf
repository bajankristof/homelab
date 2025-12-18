resource "kubernetes_secret_v1" "traefik_env" {
  depends_on = [kubernetes_namespace_v1.traefik]

  metadata {
    name      = "traefik-env"
    namespace = kubernetes_namespace_v1.traefik.metadata[0].name
  }

  type = "Opaque"

  data = {
    CLOUDFLARE_DNS_API_TOKEN = var.cloudflare_dns_api_token
  }
}
