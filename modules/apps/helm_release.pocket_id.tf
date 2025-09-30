resource "helm_release" "pocket_id" {
  name   = "pocket-id"
  chart  = "${local.charts_path}/pocket-id"
  atomic = true

  set = [
    {
      name  = "ingressRoute.host"
      value = "id.${var.cloudflare_tld}"
    },
    {
      name  = "env.APP_NAME"
      value = var.cloudflare_tld
    },
    {
      name  = "env.DB_PROVIDER"
      value = "postgres"
    },
    {
      name = "env.DB_CONNECTION_STRING"
      value = templatestring(local.postgres_url_template, {
        auth     = module.postgres_env["pocket_id"].auth
        host     = var.postgres_host
        port     = var.postgres_port
        database = module.postgres_env["pocket_id"].database.name
      })
    },
  ]
}
