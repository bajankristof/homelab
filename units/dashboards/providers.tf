provider "grafana" {
  url    = var.grafana_base_url
  auth   = "${var.grafana_admin_username}:${var.grafana_admin_password}"
  org_id = var.grafana_org_id
}
