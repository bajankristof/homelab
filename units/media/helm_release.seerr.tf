resource "helm_release" "seerr" {
  name      = "seerr"
  chart     = "${var.charts_path}/seerr"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = concat(
    module.seerr_resources.set,
    [
      {
        name  = "ingressRoute.host"
        value = var.seerr_hostname
      },
      {
        name  = "envFrom[0].configMapRef.name"
        value = kubernetes_config_map_v1.seerr_env.metadata[0].name
      },
      {
        name  = "envFrom[1].secretRef.name"
        value = kubernetes_secret_v1.seerr_env.metadata[0].name
      },
      {
        name  = "persistence.name"
        value = "seerr"
      },
      {
        name  = "persistence.storageClass"
        value = var.storage_class_name
      },
    ],
  )
}

module "seerr_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.seerr_cpu_request
  memory_request = var.seerr_memory_request
  cpu_limit      = var.seerr_cpu_limit
  memory_limit   = var.seerr_memory_limit
}
