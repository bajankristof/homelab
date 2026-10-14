resource "grafana_contact_point" "email" {
  name = "Email"

  email {
    addresses = [var.alert_email]
  }
}
