resource "helm_release" "postgres" {
  depends_on = [helm_release.metalip]

  name   = "postgres"
  chart  = "${local.charts_path}/postgres"
  atomic = true

  set = [
    {
      name  = "secrets.username"
      value = "postgres"
    },
    {
      name  = "secrets.password"
      value = random_password.postgres.result
    },
  ]
}
