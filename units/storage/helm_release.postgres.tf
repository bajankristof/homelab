resource "helm_release" "postgres" {
  name      = "postgres"
  chart     = "${local.charts_path}/postgres"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = [
    {
      name  = "envFrom[0].secretRef.name"
      value = kubernetes_config_map_v1.postgres_env.metadata[0].name
    },
    {
      name  = "envFrom[1].secretRef.name"
      value = kubernetes_secret_v1.postgres_env.metadata[0].name
    },
  ]
}
