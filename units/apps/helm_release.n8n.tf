resource "helm_release" "n8n" {
  name   = "n8n"
  chart  = "${local.charts_path}/n8n"
  atomic = true

  set = [
    {
      name  = "ingressRoute.host"
      value = "n8n.${var.cloudflare_tld}"
    },
    {
      name  = "envFrom[0].configMapRef.name"
      value = kubernetes_config_map_v1.n8n_env.metadata[0].name
    },
    {
      name  = "envFrom[1].secretRef.name"
      value = kubernetes_secret_v1.n8n_env.metadata[0].name
    },
  ]
}
