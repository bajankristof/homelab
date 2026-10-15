resource "kubernetes_manifest" "grafana_mcp_ingress_route" {
  manifest = {
    apiVersion = "traefik.io/v1alpha1"
    kind       = "IngressRoute"

    metadata = {
      name      = "grafana-mcp"
      namespace = kubernetes_namespace_v1.this.metadata[0].name
    }

    spec = {
      entryPoints = ["websecure"]

      routes = [
        {
          kind  = "Rule"
          match = "Host(`${var.grafana_mcp_hostname}`)"

          services = [
            {
              kind = "Service"
              name = "grafana-mcp"
              port = 8000
            }
          ]
        }
      ]
    }
  }

  depends_on = [helm_release.grafana_mcp]
}
