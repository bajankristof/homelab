resource "helm_release" "alloy" {
  name       = "alloy"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  version    = "1.13.1"
  namespace  = kubernetes_namespace_v1.this.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/alloy/values.yaml", {
      config = indent(6, templatefile("${path.module}/templates/alloy/config.alloy", {
        victoria_metrics_url = local.victoria_metrics_url
        victoria_logs_url    = local.victoria_logs_url
      }))
    })
  ]

  set = module.alloy_resources.set

  depends_on = [
    helm_release.kube_state_metrics,
  ]
}

module "alloy_resources" {
  source = "../modules/k8s-resources"

  prefix         = "alloy"
  cpu_request    = var.alloy_cpu_request
  memory_request = var.alloy_memory_request
  cpu_limit      = var.alloy_cpu_limit
  memory_limit   = var.alloy_memory_limit
}
