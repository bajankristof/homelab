locals {
  namespace            = kubernetes_namespace_v1.this.metadata[0].name
  grafana_url          = "http://${data.kubernetes_service_v1.grafana.metadata[0].name}.${local.namespace}.svc.cluster.local:${data.kubernetes_service_v1.grafana.spec[0].port[0].port}"
  victoria_metrics_url = "http://${data.kubernetes_service_v1.victoria_metrics.metadata[0].name}.${local.namespace}.svc.cluster.local:${data.kubernetes_service_v1.victoria_metrics.spec[0].port[0].port}"
  victoria_logs_url    = "http://${data.kubernetes_service_v1.victoria_logs.metadata[0].name}.${local.namespace}.svc.cluster.local:${data.kubernetes_service_v1.victoria_logs.spec[0].port[0].port}"
}
