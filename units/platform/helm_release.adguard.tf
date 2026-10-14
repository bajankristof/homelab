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
      {
        name  = "persistence.conf.name"
        value = "conf"
      },
      {
        name  = "persistence.work.name"
        value = "work"
      },
      {
        name  = "persistence.conf.storageClass"
        value = kubernetes_storage_class_v1.default.metadata[0].name
      },
      {
        name  = "persistence.work.storageClass"
        value = kubernetes_storage_class_v1.default.metadata[0].name
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
