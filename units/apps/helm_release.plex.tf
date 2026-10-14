resource "helm_release" "plex" {
  name   = "plex"
  chart  = "${var.charts_path}/plex"
  atomic = true

  set = [
    {
      name  = "endpoint.ip"
      value = var.plex_host_ip
    },
    {
      name  = "ingressRoute.host"
      value = var.plex_hostname
    },
  ]
}
