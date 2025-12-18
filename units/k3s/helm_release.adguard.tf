resource "helm_release" "adguard" {
  depends_on = [helm_release.metalip]

  name      = "adguard"
  chart     = "${local.charts_path}/adguard"
  namespace = kubernetes_namespace_v1.adguard.metadata[0].name
  atomic    = true

  set = [
    {
      name  = "service.loadBalancerIP"
      value = cidrhost(var.network_cidr_block, 254)
    }
  ]
}
