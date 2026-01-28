resource "helm_release" "metallb" {
  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  version    = "0.15.3"
  namespace  = kubernetes_namespace_v1.metallb_system.metadata[0].name
  atomic     = true
}
