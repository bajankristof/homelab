module "postgres_env" {
  for_each = toset(["seerr"])

  source = "../modules/postgres-env"

  host          = var.postgres_fqdn
  port          = var.postgres_port
  database_name = each.value
  role_name     = each.value
}
