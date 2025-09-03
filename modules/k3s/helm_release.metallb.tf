resource "helm_release" "metallb" {
  depends_on = [kubernetes_namespace.metallb_system]

  name       = "metallb"
  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
  namespace  = kubernetes_namespace.metallb_system.metadata[0].name
  atomic     = true
}
