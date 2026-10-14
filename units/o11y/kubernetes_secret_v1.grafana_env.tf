resource "kubernetes_secret_v1" "grafana_env" {
  metadata {
    name      = "grafana-env"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  data = {
    GF_SECURITY_ADMIN_USER     = var.grafana_admin_username
    GF_SECURITY_ADMIN_PASSWORD = random_password.grafana_admin.result
    GF_AUTH_GENERIC_OAUTH_CLIENT_SECRET = jsondecode(
      restapi_object.grafana_oidc_client.create_response
    )["createdSecret"]["secret"]
    GF_SMTP_USER     = var.smtp_username
    GF_SMTP_PASSWORD = var.smtp_password
  }
}
