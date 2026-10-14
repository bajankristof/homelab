resource "helm_release" "metallb" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = "0.16.1"
  namespace  = kubernetes_namespace_v1.metallb_system.metadata[0].name
  atomic     = true

  set = concat(
    flatten([for component in module.metallb_resources : component.set]),
    [
      {
        name  = "frrk8s.enabled"
        value = "false"
      },
    ],
  )
}

module "metallb_resources" {
  for_each = toset([
    "controller",
    "speaker",
  ])

  source = "../modules/k8s-resources"

  prefix         = each.value
  cpu_request    = var.metallb_cpu_request
  memory_request = var.metallb_memory_request
  cpu_limit      = var.metallb_cpu_limit
  memory_limit   = var.metallb_memory_limit
}
