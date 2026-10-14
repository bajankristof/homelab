resource "helm_release" "postgres" {
  name      = "postgres"
  chart     = "${var.charts_path}/postgres"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = concat(
    module.postgres_resources.set,
    [
      {
        name  = "envFrom[0].secretRef.name"
        value = kubernetes_config_map_v1.postgres_env.metadata[0].name
      },
      {
        name  = "envFrom[1].secretRef.name"
        value = kubernetes_secret_v1.postgres_env.metadata[0].name
      },
    ],
  )
}

module "postgres_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.postgres_cpu_request
  memory_request = var.postgres_memory_request
  cpu_limit      = var.postgres_cpu_limit
  memory_limit   = var.postgres_memory_limit
}
