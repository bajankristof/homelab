module "postgres_env" {
  for_each = toset(["n8n"])

  source = "../modules/postgres-env"

  host          = var.postgres_fqdn
  port          = var.postgres_port
  database_name = each.value
  role_name     = each.value
}
