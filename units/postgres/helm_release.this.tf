resource "helm_release" "this" {
  name      = "postgres"
  chart     = "${var.charts_path}/postgres"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = concat(
    module.resources.set,
    [
      {
        name  = "envFrom[0].secretRef.name"
        value = kubernetes_config_map_v1.env.metadata[0].name
      },
      {
        name  = "envFrom[1].secretRef.name"
        value = kubernetes_secret_v1.env.metadata[0].name
      },
      {
        name  = "persistence.name"
        value = "data"
      },
      {
        name  = "persistence.storageClass"
        value = var.storage_class_name
      },
    ],
  )
}

module "resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.cpu_request
  memory_request = var.memory_request
  cpu_limit      = var.cpu_limit
  memory_limit   = var.memory_limit
}
