resource "helm_release" "traefik" {
  depends_on = [helm_release.metalip]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "41.5.0"
  namespace  = kubernetes_namespace_v1.traefik.metadata[0].name
  atomic     = true

  values = [
    templatefile("${path.module}/templates/traefik/values.yaml", {
      hostname   = var.traefik_hostname
      acme_email = var.acme_email
      env_secret = kubernetes_secret_v1.traefik_env.metadata[0].name
    })
  ]

  set = module.traefik_resources.set
}

module "traefik_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.traefik_cpu_request
  memory_request = var.traefik_memory_request
  cpu_limit      = var.traefik_cpu_limit
  memory_limit   = var.traefik_memory_limit
}
