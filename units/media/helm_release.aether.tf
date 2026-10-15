resource "helm_release" "aether" {
  name      = "aether"
  chart     = "${var.charts_path}/aether"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = concat(
    module.aether_resources.set,
    [
      {
        name  = "ingressRoute.host"
        value = var.aether_hostname
      },
      {
        name  = "persistence.name"
        value = "aether"
      },
      {
        name  = "persistence.storageClass"
        value = var.storage_class_name
      },
      {
        name  = "envFrom[0].configMapRef.name"
        value = kubernetes_config_map_v1.aether_env.metadata[0].name
      },
      {
        name  = "envFrom[1].secretRef.name"
        value = kubernetes_secret_v1.aether_env.metadata[0].name
      },
    ],
  )
}

module "aether_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.aether_cpu_request
  memory_request = var.aether_memory_request
  cpu_limit      = var.aether_cpu_limit
  memory_limit   = var.aether_memory_limit
}
