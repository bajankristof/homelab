resource "helm_release" "plex" {
  name      = "plex"
  chart     = "${var.charts_path}/plex"
  namespace = kubernetes_namespace_v1.this.metadata[0].name
  atomic    = true

  set = concat(
    module.plex_resources.set,
    [
      {
        name  = "ingressRoute.host"
        value = var.plex_hostname
      },
      {
        name  = "env.TZ"
        value = "Europe/Budapest"
      },
      {
        name  = "env.PLEX_UID"
        value = "1000"
      },
      {
        name  = "env.PLEX_GID"
        value = "1000"
      },
      {
        name  = "persistence.config.name"
        value = "plex"
      },
      {
        name  = "persistence.config.storageClass"
        value = var.storage_class_name
      },
      {
        name  = "persistence.aether.name"
        value = "plex-aether"
      },
      {
        name  = "persistence.aether.storageClass"
        value = kubernetes_storage_class_v1.aether.metadata[0].name
      },
      {
        name  = "persistence.media.existingClaim"
        value = kubernetes_persistent_volume_claim_v1.media.metadata[0].name
      },
      {
        name  = "gpu.supplementalGroups[0]"
        value = "983"
      },
      {
        name  = "gpu.supplementalGroups[1]"
        value = "987"
      },
    ],
    var.plex_claim != "" ? [{
      name  = "env.PLEX_CLAIM"
      value = var.plex_claim
    }] : [],
  )
}

module "plex_resources" {
  source = "../modules/k8s-resources"

  cpu_request    = var.plex_cpu_request
  memory_request = var.plex_memory_request
  cpu_limit      = var.plex_cpu_limit
  memory_limit   = var.plex_memory_limit
}
