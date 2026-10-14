resource "restapi_object" "grafana_oidc_client" {
  ignore_all_server_changes = true

  path = "/api/oidc/clients"
  data = jsonencode({
    id           = "grafana"
    name         = "Grafana"
    callbackURLs = ["${var.grafana_base_url}/login/generic_oauth"]
    skipConsent  = true
    hasLogo      = true
    logoUrl      = "https://raw.githubusercontent.com/grafana/grafana/v12.3.1/public/img/grafana_icon.svg"
    hasDarkLogo  = true
    darkLogoUrl  = "https://raw.githubusercontent.com/grafana/grafana/v12.3.1/public/img/grafana_mask_icon_white.svg"
  })
}
