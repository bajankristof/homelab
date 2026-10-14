resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana-community.github.io/helm-charts"
  chart      = "grafana"
  version    = "13.5.1"
  namespace  = kubernetes_namespace_v1.this.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/grafana/values.yaml", {
      hostname             = var.grafana_hostname
      base_url             = var.grafana_base_url
      victoria_metrics_url = local.victoria_metrics_url
      victoria_logs_url    = local.victoria_logs_url
      oidc_auth_url        = var.oidc_auth_url
      oidc_token_url       = var.oidc_token_url
      oidc_userinfo_url    = var.oidc_userinfo_url
      oidc_client_id       = restapi_object.grafana_oidc_client.id
      smtp_host            = var.smtp_host
      smtp_port            = var.smtp_port
      smtp_from_address    = var.smtp_from_address
      env_secret           = kubernetes_secret_v1.grafana_env.metadata[0].name
      volume_claim         = kubernetes_persistent_volume_claim_v1.grafana.metadata[0].name
    })
  ]

  set = module.grafana_resources.set
}

module "grafana_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.grafana_cpu_request
  memory_request = var.grafana_memory_request
  cpu_limit      = var.grafana_cpu_limit
  memory_limit   = var.grafana_memory_limit
}
