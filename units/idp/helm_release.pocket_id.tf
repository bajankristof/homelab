resource "helm_release" "pocket_id" {
  name   = "pocket-id"
  chart  = "${local.charts_path}/pocket-id"
  atomic = true

  set = [
    {
      name  = "ingressRoute.host"
      value = "id.${var.cloudflare_tld}"
    },
    {
      name  = "envFrom[0].configMapRef.name"
      value = kubernetes_config_map_v1.pocket_id_env.metadata[0].name
    },
    {
      name  = "envFrom[1].secretRef.name"
      value = kubernetes_secret_v1.pocket_id_env.metadata[0].name
    },
  ]
}
