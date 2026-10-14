resource "helm_release" "adguard" {
  depends_on = [helm_release.metalip]

  name      = "adguard"
  chart     = "${var.charts_path}/adguard"
  namespace = kubernetes_namespace_v1.adguard.metadata[0].name
  atomic    = true

  set = concat(
    module.adguard_resources.set,
    [
      {
        name  = "service.loadBalancerIP"
        value = cidrhost(var.network_cidr_block, 254)
      },
    ],
  )
}

module "adguard_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.adguard_cpu_request
  memory_request = var.adguard_memory_request
  cpu_limit      = var.adguard_cpu_limit
  memory_limit   = var.adguard_memory_limit
}
