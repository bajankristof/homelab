resource "helm_release" "metalip" {
  depends_on = [helm_release.metallb]

  name      = "metalip"
  chart     = "${local.charts_path}/metalip"
  namespace = kubernetes_namespace_v1.metallb_system.metadata[0].name
  atomic    = true

  set_list = [
    {
      name = "ipAddressPool.addresses"
      value = [
        join("-", [
          cidrhost(var.network_cidr_block, 201),
          cidrhost(var.network_cidr_block, 254)
        ])
      ]
    }
  ]
}
