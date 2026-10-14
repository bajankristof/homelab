resource "helm_release" "victoria_metrics" {
  name       = "victoria-metrics"
  repository = "https://victoriametrics.github.io/helm-charts/"
  chart      = "victoria-metrics-single"
  version    = "0.49.0"
  namespace  = kubernetes_namespace_v1.observability.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/victoria-metrics/values.yaml", {
      name_override  = "victoria-metrics"
      retention_days = var.victoria_metrics_retention_days
      volume_claim   = kubernetes_persistent_volume_claim_v1.victoria_metrics.metadata[0].name
    })
  ]

  set = module.victoria_metrics_resources.set
}

module "victoria_metrics_resources" {
  source = "../modules/k8s-resources"

  prefix         = "server"
  cpu_request    = var.victoria_metrics_cpu_request
  memory_request = var.victoria_metrics_memory_request
  cpu_limit      = var.victoria_metrics_cpu_limit
  memory_limit   = var.victoria_metrics_memory_limit
}
