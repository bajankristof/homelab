resource "grafana_notification_policy" "default" {
  contact_point   = grafana_contact_point.email.name
  group_by        = ["grafana_folder", "alertname"]
  group_wait      = "30s"
  group_interval  = "5m"
  repeat_interval = "4h"
}
