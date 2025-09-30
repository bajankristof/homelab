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
      name  = "env.DB_CONNECTION_STRING"
      value = "postgres://${urlencode(postgresql_role.pocket_id.name)}:${urlencode(random_password.postgres_pocket_id.result)}@${var.postgres_host}:${var.postgres_port}/${postgresql_database.pocket_id.name}?sslmode=disable"
    },
  ]
}
