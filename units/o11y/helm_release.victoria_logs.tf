resource "helm_release" "victoria_logs" {
  name       = "victoria-logs"
  repository = "https://victoriametrics.github.io/helm-charts/"
  chart      = "victoria-logs-single"
  version    = "0.13.10"
  namespace  = kubernetes_namespace_v1.this.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/victoria-logs/values.yaml", {
      name_override  = "victoria-logs"
      retention_days = var.victoria_logs_retention_days
      volume_claim   = kubernetes_persistent_volume_claim_v1.victoria_logs.metadata[0].name
    })
  ]

  set = module.victoria_logs_resources.set
}

module "victoria_logs_resources" {
  source = "../modules/k8s-resources"

  prefix         = "server"
  cpu_request    = var.victoria_logs_cpu_request
  memory_request = var.victoria_logs_memory_request
  cpu_limit      = var.victoria_logs_cpu_limit
  memory_limit   = var.victoria_logs_memory_limit
}
