resource "helm_release" "seerr" {
  name   = "seerr"
  chart  = "${var.charts_path}/seerr"
  atomic = true

  set = [
    {
      name  = "ingressRoute.host"
      value = "seerr.${var.cloudflare_tld}"
    },
    {
      name  = "envFrom[0].configMapRef.name"
      value = kubernetes_config_map_v1.seerr_env.metadata[0].name
    },
    {
      name  = "envFrom[1].secretRef.name"
      value = kubernetes_secret_v1.seerr_env.metadata[0].name
    },
  ]
}
