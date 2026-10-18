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

output "otlp_metrics_endpoint" {
  value = "${local.victoria_metrics_url}/opentelemetry/v1/metrics"
}

output "otlp_metrics_protocol" {
  value = "http/protobuf"
}

output "otlp_logs_endpoint" {
  value = "${local.victoria_logs_url}/opentelemetry/v1/logs"
}

output "otlp_logs_protocol" {
  value = "http/protobuf"
}
