resource "helm_release" "plex" {
  name   = "plex"
  chart  = "${var.charts_path}/plex"
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
