resource "helm_release" "upsnap" {
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
