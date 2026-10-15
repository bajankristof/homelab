resource "kubernetes_secret_v1" "grafana_mcp_env" {
  metadata {
    name      = "grafana-mcp-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    MCP_GRAFANA_SERVER_TOKEN = random_password.grafana_mcp_server_token.result
  }
}
