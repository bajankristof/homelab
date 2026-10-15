resource "random_password" "grafana_mcp_server_token" {
  length  = 48
  special = false
}
