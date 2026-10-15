resource "helm_release" "grafana_mcp" {
  name       = "grafana-mcp"
  repository = "https://grafana-community.github.io/helm-charts"
  chart      = "grafana-mcp"
  version    = "0.27.2"
  namespace  = kubernetes_namespace_v1.this.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/grafana-mcp/values.yaml", {
      grafana_url        = local.grafana_url
      hostname           = var.grafana_mcp_hostname
      grafana_env_secret = kubernetes_secret_v1.grafana_env.metadata[0].name
      env_secret         = kubernetes_secret_v1.grafana_mcp_env.metadata[0].name
    })
  ]

  set = module.grafana_mcp_resources.set
}

module "grafana_mcp_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.grafana_mcp_cpu_request
  memory_request = var.grafana_mcp_memory_request
  cpu_limit      = var.grafana_mcp_cpu_limit
  memory_limit   = var.grafana_mcp_memory_limit
}
