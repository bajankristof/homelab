resource "helm_release" "kube_state_metrics" {
  name       = "kube-state-metrics"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-state-metrics"
  version    = "8.6.0"
  namespace  = kubernetes_namespace_v1.this.metadata[0].name
  atomic     = true

  set = module.kube_state_metrics_resources.set
}

module "kube_state_metrics_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.kube_state_metrics_cpu_request
  memory_request = var.kube_state_metrics_memory_request
  cpu_limit      = var.kube_state_metrics_cpu_limit
  memory_limit   = var.kube_state_metrics_memory_limit
}
