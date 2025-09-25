resource "helm_release" "traefik" {
  depends_on = [
    helm_release.metalip,
    kubernetes_namespace.traefik,
    kubernetes_secret.traefik_env,
  ]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = kubernetes_namespace.traefik.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/traefik/values.yaml", {
      acme_email = var.acme_email
    })
  ]

  set = [
    {
      name  = "envFrom[0].secretRef.name"
      value = kubernetes_secret.traefik_env.metadata[0].name
    },
    {
      name  = "service.spec.loadBalancerIP"
      value = cidrhost(var.network_cidr_block, 234)
    },
  ]
}
