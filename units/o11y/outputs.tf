output "grafana_base_url" {
  value = var.grafana_base_url
}

output "grafana_mcp_base_url" {
  value = var.grafana_mcp_base_url
}

output "grafana_admin_username" {
  value = var.grafana_admin_username
}

output "grafana_admin_password" {
  value     = random_password.grafana_admin.result
  sensitive = true
}
