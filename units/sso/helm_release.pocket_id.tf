resource "helm_release" "pocket_id" {
  name      = "pocket-id"
  chart     = "${var.charts_path}/pocket-id"
  namespace = kubernetes_namespace_v1.pocket_id.metadata[0].name
  atomic    = true

  set = concat(
    module.resources.set,
    [
      {
        name  = "ingressRoute.host"
        value = var.hostname
      },
      {
        name  = "envFrom[0].configMapRef.name"
        value = kubernetes_config_map_v1.pocket_id_env.metadata[0].name
      },
      {
        name  = "envFrom[1].secretRef.name"
        value = kubernetes_secret_v1.pocket_id_env.metadata[0].name
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
