resource "helm_release" "adguard" {
  depends_on = [helm_release.metalip]

  name   = "adguard"
  chart  = "${local.charts_path}/adguard"
  atomic = true

  set = [
    {
      name  = "loadBalancerIP"
      value = cidrhost(var.network_cidr_block, 254)
    }
  ]
}
