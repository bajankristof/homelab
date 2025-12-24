resource "helm_release" "traefik" {
  depends_on = [helm_release.metalip]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = kubernetes_namespace_v1.traefik.metadata[0].name
  atomic     = true

  values = [
    file("${path.module}/templates/traefik/values.yaml")
  ]

  set = [
    {
      name  = "service.spec.loadBalancerIP"
      value = cidrhost(var.network_cidr_block, 234)
    },
    {
      name  = "certificatesResolvers.letsencrypt.acme.email"
      value = var.acme_email
    },
    {
      name  = "envFrom[0].secretRef.name"
      value = kubernetes_secret_v1.traefik_env.metadata[0].name
    },
  ]
}
