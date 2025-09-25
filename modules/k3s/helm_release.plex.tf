resource "helm_release" "plex" {
  depends_on = [helm_release.traefik]

  name   = "plex"
  chart  = "${local.charts_path}/plex"
  atomic = true

  set = [
    {
      name  = "endpoint.ip"
      value = cidrhost(var.network_cidr_block, 2)
    },
    {
      name  = "ingressRoute.host"
      value = "plex.${var.cloudflare_tld}"
    },
  ]
}
