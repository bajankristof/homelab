resource "helm_release" "traefik" {
  depends_on = [helm_release.metalip]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = kubernetes_namespace_v1.traefik.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/traefik/values.yaml", {
      acme_email = var.acme_email
    })
  ]

  set = [
    {
      name  = "service.spec.loadBalancerIP"
      value = cidrhost(var.network_cidr_block, 234)
    },
    {
      name  = "envFrom[0].secretRef.name"
      value = kubernetes_secret_v1.traefik_env.metadata[0].name
    },
  ]
}
