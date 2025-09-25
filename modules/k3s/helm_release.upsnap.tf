resource "helm_release" "upsnap" {
  depends_on = [helm_release.traefik]

  name   = "upsnap"
  chart  = "${local.charts_path}/upsnap"
  atomic = true

  set = [
    {
      name  = "ingressRoute.host"
      value = "upsnap.${var.cloudflare_tld}"
    },
  ]
}
